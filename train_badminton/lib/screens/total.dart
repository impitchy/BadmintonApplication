import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_badminton/screens/activity.dart';
import 'package:train_badminton/screens/home.dart';
import 'package:train_badminton/screens/manu.dart';
import 'package:train_badminton/screens/training.dart';

class Total extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'ผลรวม',
            style: TextStyle(
              color: const Color.fromARGB(
                  255, 255, 255, 255), // สีข้อความใน Appbar
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFC63D2F),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFFFF6F4EB),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Center(
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          -10.0,
                        ),
                        child: CustomPaint(
                          size: Size(300, 300),
                          painter: BadmintonCourtPainter(),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        5,
                        40,
                      ),
                      child: Center(
                        child: Container1([]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
            icon: Icon(Icons.logout),
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
}

class Container1 extends StatelessWidget {
  final List<Widget> buttons;

  Container1(this.buttons);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 350,
              height: 240,
              child: Text(
                '  รอบที่ 1 จุด1 --> จุด2   เวลา 0.7 วินาที\n  รอบที่ 2 จุด2 --> จุด3   เวลา 0.3 วินาที\n  รอบที่ 3 จุด3 --> จุด4   เวลา 0.9 วินาที\n  รอบที่ 4 จุด4 --> จุด5   เวลา 0.9 วินาที\n  รอบที่ 5 จุด5 --> จุด6   เวลา 0.9 วินาที\n  รอบที่ 6 จุด6 --> จุด7   เวลา 0.9 วินาที\n',
                textScaleFactor: 1.5,
                style: GoogleFonts.maitree(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFFD9C0),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            Positioned(
              top: 195,
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Activity()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE25E3E),
                    onPrimary: Color(0xFFF9F9F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(130, 30),
                  ),
                  child: Text(
                    'ดูสถิติการเล่นเพิ่มเติม',
                    style: GoogleFonts.maitree(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttons,
        ),
      ],
    );
  }
}

class BadmintonCourtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF9ADE7B)
      ..style = PaintingStyle.fill;

    final courtRect = Rect.fromPoints(
      Offset(0, 0),
      Offset(size.width, size.height),
    );

    canvas.drawRect(courtRect, paint);

    final netPaint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final centerX = size.width / 2;
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, size.height), netPaint);

    final topY = size.height / 8;
    canvas.drawLine(Offset(0, topY), Offset(size.width, topY), netPaint);

    final bottomY = size.height - (size.height / 8);
    canvas.drawLine(Offset(0, bottomY), Offset(size.width, bottomY), netPaint);

    final middleX = centerX;
    canvas.drawLine(Offset(middleX, topY), Offset(middleX, bottomY), netPaint);

    canvas.drawLine(Offset(0, 0), Offset(0, size.height), netPaint);

    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, size.height), netPaint);

    // วาดวงกลม
    drawCircles(canvas, size);
  }

  void drawVerticalLine(
      Canvas canvas, double x, double startY, double endY, Color color) {
    Paint linePaint = Paint()..color = color;
    canvas.drawLine(Offset(x, startY), Offset(x, endY), linePaint);
  }

  void drawCircles(Canvas canvas, Size size) {
    List<Offset> circlePositions = [
      Offset(5, size.height / 2),
      Offset(5, 50),
      Offset(5, size.height - 50),
      Offset(size.width / 2, size.height / 2),
      Offset(size.width - 5, 150),
      Offset(size.width - 5, size.height - 50),
      Offset(size.width - 5, size.height / 6),
    ];

    double radius = 10;

    for (Offset position in circlePositions) {
      Paint circlePaint = Paint()..color = Colors.red;
      canvas.drawCircle(position, radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

void main() {
  runApp(MaterialApp(
    home: Total(),
  ));
}
