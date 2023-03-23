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
  final Size cellSize;
  final Color? monthLabelColor;
  final double? monthLabelFontSize;
  final int labelTextSizeMultiple;
  final DateFormat Function(DateTime date)? getFormat;
  final EdgeInsets Function(int columnIndex)? getCellPadding;
  final MonthLabelValueBuilder? monthLabelItemBuilder;

  const MonthLabelRow({
    super.key,
    required this.model,
    required this.cellSize,
    this.monthLabelColor,
    this.monthLabelFontSize,
    this.labelTextSizeMultiple = 3,
    this.getFormat,
    this.getCellPadding,
    this.monthLabelItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    var dateMap = <int, DateTime>{};
    if (model.startDate.day == 1) {
      dateMap[model.getOffsetColumn(model.startDate)] = model.startDate;
    }
    var tmpDate = model.startDate;
    while (tmpDate.isBefore(model.endedDate)) {
      tmpDate = DateTime(tmpDate.year, tmpDate.month + 1, 1);
      dateMap[model.getOffsetColumn(tmpDate)] = tmpDate;
    }

    var children = <Widget>[];
    var columns = model.offsetColumnWithEndDate + 1;

    var columnIndex = 0;
    var maxColumnIndex = model.offsetColumnWithEndDate;
    while (columnIndex < maxColumnIndex) {
      var cellPadding = getCellPadding?.call(columnIndex) ?? EdgeInsets.zero;
      if (dateMap.containsKey(columnIndex) &&
          (columns - columnIndex) >= labelTextSizeMultiple) {
        var date = dateMap[columnIndex]!;
        var format = getFormat?.call(date) ?? DateFormat.yM();
        children.add(MonthLabelItem(
          date: date,
          monthLabelColor: monthLabelColor,
          monthLabelFontSize: monthLabelFontSize,
          padding: cellPadding,
          innderWidth: cellSize.width * labelTextSizeMultiple +
              cellPadding.left * (labelTextSizeMultiple - 1),
          format: format,
          monthLabelItemBuilder: monthLabelItemBuilder,
        ));
        columnIndex += labelTextSizeMultiple;
      } else {
        children.add(
          Padding(
            padding: cellPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: cellSize.width),
            ),
          ),
        );
        columnIndex += 1;
      }
    }

    return Row(children: children);
  }
}
