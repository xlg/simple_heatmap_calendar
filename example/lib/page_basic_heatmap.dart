import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_heatmap_calendar/simple_heatmap_calendar.dart';

class BasicHeatmapPage extends StatefulWidget {
  const BasicHeatmapPage({super.key});

  @override
  State<StatefulWidget> createState() => _BasicHeatmapPage();
}

class _BasicHeatmapPage extends State<BasicHeatmapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Heatmap Calendar"),
      ),
      body: ListView(
        children: [
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Column(
          //       children: [
          //         const ListTile(
          //             title: Text("Default (2023-1-3 to 2023-04-10)")),
          //         HeatmapCalendar<num>(
          //           startDate: DateTime(2023, 1, 3),
          //           endedDate: DateTime(2023, 4, 10),
          //           layoutParameters: const HeatmapLayoutParameters.defaults(
          //             defaultScrollPosition: CalendarScrollPosition.start,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Column(
          //       children: [
          //         const ListTile(title: Text("With labels")),
          //         HeatmapCalendar<num>(
          //           startDate: DateTime(2023, 1, 3),
          //           // endedDate: DateTime(2023, 4, 12),
          //           endedDate: DateTime.now(),
          //           firstDay: DateTime.monday,
          //           //这是cell的背景色，例如<10,10-20,20-30，>30的颜色
          //           colorMap: {
          //             10: Colors.red.shade100,
          //             20: Colors.red.shade300,
          //             30: Colors.red.shade500,
          //             40: Colors.red.shade700,
          //             // 50: Colors.red.shade900,
          //             50: Colors.blue,
          //           },
          //           //这是cell里的value的颜色值
          //           valueColorMap: const {
          //             10: Colors.black,
          //             20: Colors.white,
          //             39: Colors.yellow,
          //           },
          //           colorTipNum: 3,//底部颜色标签展示几个颜色
          //           colorTipCellSize: const Size.square(16),//底部标签块的大小
          //           layoutParameters: const HeatmapLayoutParameters.defaults(
          //             monthLabelPosition: CalendarMonthLabelPosition.top,
          //             weekLabelPosition: CalendarWeekLabelPosition.right,
          //             colorTipPosition: CalendarColorTipPosition.bottom,
          //           ),
          //           style: const HeatmapCalendarStyle.defaults(
          //             colorTipPosOffset: 50,
          //           ),
          //           switchParameters: const HeatmapSwitchParameters.defaults(
          //             showCellText: true,
          //           ),
          //           selectedMap: {
          //             DateTime(2023, 4, 1): 1,
          //             DateTime(2023, 4, 2): 9,
          //             DateTime(2023, 4, 3): 12,
          //             DateTime(2023, 4, 4): 25,
          //             DateTime(2023, 4, 5): 35,
          //             DateTime(2023, 4, 6): 42,
          //             DateTime(2023, 4, 7): 999,
          //           },
          //           callbackModel: HeatmapCallbackModel(
          //             onCellPressed: (date, value) {
          //               print('date=$date,value=$value');
          //             },
          //             onCellLongPressed: (date, value) async {
          //               print('date=$date,value=$value');
          //             },
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const ListTile(title: Text("Scaled")),
                  HeatmapCalendar<num>(
                    startDate: DateTime(2022, 11, 1),
                    endedDate: DateTime(2023, 12, 2),
                    firstDay: DateTime.monday,
                    // weekLabalCellSize: Size.fromWidth(1),
                    // cellSize: Size.square(16),//每个格子的大小
                    // colorTipCellSize: const Size.square(16),

                    colorMap: {
                      1:Colors.black,
                      10: Colors.grey,
                      20: Colors.red.shade300,
                      30: Colors.red.shade500,
                      40: Colors.red.shade700,
                      // 50: Colors.red.shade900,
                      50: Colors.blue,
                    },
                    selectedMap: {
                      DateTime(2023, 4, 1): 1,
                      DateTime(2023, 4, 2): 9,
                      DateTime(2023, 4, 3): 12,
                      DateTime(2023, 4, 4): 25,
                      DateTime(2023, 4, 5): 35,
                      DateTime(2023, 4, 6): 42,
                      DateTime(2023, 4, 7): 999,
                    },

                    layoutParameters: const HeatmapLayoutParameters.defaults(
                      monthLabelPosition: CalendarMonthLabelPosition.top,
                      // weekLabelPosition: CalendarWeekLabelPosition.right,
                      weekLabelPosition: null,
                    ),
                    style: const HeatmapCalendarStyle.defaults(
                      showYearOnMonthLabel: false,//是否显示年


                    ),
                    switchParameters: const HeatmapSwitchParameters.defaults(
                      showCellText: false,//格子里是否显示值


                      // autoScaled: true,
                    ),
                    monthLabelItemBuilder: (context, date, defaultFormat) =>
                        FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(DateFormat(defaultFormat).format(date)),
                        ),
                    callbackModel: HeatmapCallbackModel(//点击回调
                      onCellPressed: (date, value) {
                        print('date=$date,value$value');
                      },
                      onCellLongPressed: (date, value) async {
                        print('date=$date,value$value');
                      },
                    ),
                    // weekLabelValueBuilder: ( BuildContext context,
                    //     DateTime protoDate,
                    //     String defaultFormat,){
                    //   return null;
                    // },
                    // cellBuilder:
                    //     (context, childBuilder, columnIndex, rowIndex, date) =>
                    //         childBuilder(
                    //   context,
                    //   valueBuilder: (context, dateDay) {
                    //     if (dateDay == 1) {
                    //       return const Icon(Icons.tonality);
                    //     } else {
                    //       return const Icon(Icons.circle_outlined);
                    //     }
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
      //   body: ListView.separated(
      //       itemBuilder: (BuildContext context, int index) {
      //         return Container(
      //           width: 50,
      //           height: 50,
      //           color: Colors.blue,
      //           child: Text("aaa",style: TextStyle(color: Colors.red,fontSize: 14)),
      //         );
      //       },
      //       separatorBuilder: (BuildContext context, int index) {
      //         return const SizedBox(
      //           height: 20,
      //         );
      //       },
      //       itemCount: 3),
    );
  }
}
