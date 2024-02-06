import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:train_badminton/screens/home.dart';
import 'package:train_badminton/screens/manu.dart';
import 'package:train_badminton/screens/training.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Activity(),
    );
  }
}

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  DateTime _selectedDay = DateTime.now();
  PageController _pageController = PageController();
  DateTime lastDay = DateTime.utc(2024, 12, 31); // ปรับปีเป็น 2024
  DateTime focusedDay = DateTime.utc(2024, 1, 1); // ปรับปีเป็น 2024

  Map<DateTime, List<double>> dailyGameData = {
    DateTime.utc(2024, 1, 1): [5.0, 4.0], // ปรับปีเป็น 2024
    DateTime.utc(2024, 1, 2): [0.5, 5.0], // ปรับปีเป็น 2024
    DateTime.utc(2024, 1, 3): [3.0, 6.0], // ปรับปีเป็น 2024
    DateTime.utc(2024, 1, 4): [3.0], // ปรับปีเป็น 2024
    DateTime.utc(2024, 1, 5): [2.0, 7.0], // ปรับปีเป็น 2024
    DateTime.utc(2024, 1, 6): [1.0], // ปรับปีเป็น 2024
    DateTime.utc(2024, 1, 7): [0.5], // ปรับปีเป็น 2024
  };

  List<ChartData> getChartData() {
    List<double> chartData = dailyGameData[_selectedDay] ?? [];
    chartData = chartData.where((value) => value.isFinite).toList();

    List<ChartData> dataPoints = chartData.asMap().entries.map((entry) {
      return ChartData(
        x: entry.key + 1,
        y: entry.value,
      );
    }).toList();

    return dataPoints;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: _selectedDay
            .difference(DateTime.utc(2024, 1, 1))
            .inDays); // ปรับปีเป็น 2024
    focusedDay = DateTime.utc(2024, 1, 1); // ปรับปีเป็น 2024
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'สถิติ',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFC63D2F),
        ),
      ),
      backgroundColor: Color(0xFFFF6F4EB),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedDay = DateTime.utc(2024, 1, 1)
                        .add(Duration(days: index)); // ปรับปีเป็น 2024
                  });
                },
                children: [
                  _buildTableCalendar(),
                  _buildLineChart(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_tennis_outlined),
            label: 'เล่น',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.door_back_door_rounded),
            label: 'ออกจากระบบ',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.amber[800],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Manu()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Training()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildTableCalendar() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                if (lastDay != null &&
                    !isSameDay(focusedDay, lastDay) &&
                    focusedDay.isBefore(lastDay))
                  TableCalendar(
                    focusedDay: focusedDay,
                    firstDay: DateTime.utc(2024, 1, 1), // ปรับปีเป็น 2024
                    lastDay: lastDay,
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        this.focusedDay = selectedDay;
                      });
                    },
                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      leftChevronIcon: Icon(Icons.chevron_left),
                      rightChevronIcon: Icon(Icons.chevron_right),
                    ),
                    onFormatChanged: (format) {
                      // Handle format change
                      if (format == CalendarFormat.month) {
                        // Code for monthly view
                      } else {
                        // Code for weekly view
                      }
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                  ),
                if (lastDay == null ||
                    isSameDay(focusedDay, lastDay) ||
                    !focusedDay.isBefore(lastDay))
                  Text('Invalid date range'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    List<ChartData> dataPoints = getChartData();

    return Expanded(
      child: Container(
        height: 300,
        padding: EdgeInsets.all(16),
        child: SfCartesianChart(
          primaryXAxis: NumericAxis(
            title: AxisTitle(text: 'รอบการเล่น'),
            minimum: 1, // กำหนดให้เริ่มต้นที่ 1
            maximum: 10, // กำหนดให้สิ้นสุดที่ 10
            interval: 1, // กำหนดระยะห่างระหว่างตัวเลขเป็น 1
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'วินาที'),
          ),
          series: <LineSeries<ChartData, double>>[
            LineSeries<ChartData, double>(
              dataSource: dataPoints,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              color: const Color.fromARGB(255, 243, 100, 33),
            ),
          ],
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enableDoubleTapZooming: true,
            zoomMode: ZoomMode.x,
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final double x;
  final double y;

  ChartData({required this.x, required this.y});
}
