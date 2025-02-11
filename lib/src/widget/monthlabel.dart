import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../heatmap_calendar.dart';
import '../utils.dart';

class MonthLabelItem extends StatelessWidget {
  final DateTime date;
  final Color? monthLabelColor;
  final double? monthLabelFontSize;
  final EdgeInsetsGeometry padding;
  final double? innderWidth;
  final double? innderHeight;
  final DateFormat format;
  final MonthLabelValueBuilder? monthLabelItemBuilder;

  const MonthLabelItem({
    super.key,
    required this.date,
    this.monthLabelColor,
    this.monthLabelFontSize,
    required this.padding,
    this.innderWidth,
    this.innderHeight,
    required this.format,
    this.monthLabelItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: innderWidth,
        height: innderHeight,
        child: DefaultTextStyle(
          style:
          TextStyle(color: monthLabelColor, fontSize: monthLabelFontSize),
          child: monthLabelItemBuilder?.call(
              context, date, format.pattern ?? '') ??
              Text(format.format(date)),
        ),
      ),
    );
  }
}

class MonthLabelRow extends StatelessWidget {
  final HeatmapCalendarLocationCalclator model;
  final double? offset;
  final CalendarWeekLabelPosition? weekLabelLocation;
  final Size cellSize;
  final double cellSpaceBetween;
  final Color? monthLabelColor;
  final double? monthLabelFontSize;
  final int labelTextSizeMultiple;
  final DateFormat Function(DateTime date)? getFormat;
  final EdgeInsets Function(int columnIndex)? getCellPadding;
  final MonthLabelValueBuilder? monthLabelItemBuilder;

  const MonthLabelRow({
    super.key,
    this.offset,
    this.weekLabelLocation,
    required this.model,
    required this.cellSize,
    this.cellSpaceBetween = 0,
    this.monthLabelColor,
    this.monthLabelFontSize,
    this.labelTextSizeMultiple = 3,
    this.getFormat,
    this.getCellPadding,
    this.monthLabelItemBuilder,
  }) : assert(labelTextSizeMultiple > 0);

  @override
  Widget build(BuildContext context) {
    var dateMap = <int, DateTime>{};
    if (model.startDate.day == 1) {
      dateMap[model.getOffsetColumn(model.startDate)] = model.startDate;
    }
    var tmpDate = model.startDate;
    while (tmpDate.isBefore(model.endedDate) || tmpDate.millisecondsSinceEpoch == model.endedDate.millisecondsSinceEpoch) {
      dateMap[model.getOffsetColumn(tmpDate)] = tmpDate;//添加小于end的
      tmpDate = DateTime(tmpDate.year, tmpDate.month + 1, 1);
    }
    // dateMap[model.getOffsetColumn(model.endedDate)] = model.endedDate;//直接加个最后的

    var children = <Widget>[];
    var columns = model.offsetColumnWithEndDate + 1;

    if (offset != null &&
        offset! > 0 &&
        weekLabelLocation == CalendarWeekLabelPosition.left) {
      children.add(SizedBox(width: offset!));
    }

    var columnIndex = 0;
    var maxColumnIndex = model.offsetColumnWithEndDate;
    while (columnIndex <= maxColumnIndex) {
      var cellPadding = getCellPadding?.call(columnIndex) ?? EdgeInsets.zero;
      var gapCount = columns - columnIndex;
      if (dateMap.containsKey(columnIndex)) { //labelTextSizeMultiple 相当于说月的宽度占据多少个cell,这里是3个
        var date = dateMap[columnIndex]!;
        var format = getFormat?.call(date) ?? DateFormat.yM();
        children.add(MonthLabelItem(
          date: date,
          monthLabelColor: monthLabelColor,
          monthLabelFontSize: monthLabelFontSize,
          padding: cellPadding,
          // innderWidth: (columns - columnIndex) >= labelTextSizeMultiple?cellSize.width * labelTextSizeMultiple +
          //     cellSpaceBetween * (labelTextSizeMultiple - 1):gapCount * cellSize.width+(gapCount-1)*
          //     cellSpaceBetween,
          innderWidth:cellSize.width,//妈的，这里大小直接认为和cell一样大了
          format: format,
          monthLabelItemBuilder: monthLabelItemBuilder,
        ));
        // columnIndex += labelTextSizeMultiple;
        // columnIndex += 1;
      } else {
        children.add(
          Padding(
            padding: cellPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: cellSize.width),
            ),
          ),
        );
        // columnIndex += 1;
      }

      if (columnIndex < maxColumnIndex) {
        children.add(SizedBox(width: cellSpaceBetween));
      }
      columnIndex += 1;
    }

    if (offset != null &&
        offset! > 0 &&
        weekLabelLocation == CalendarWeekLabelPosition.right) {
      children.add(SizedBox(width: offset));
    }

    return Row(children: children);
  }
}
