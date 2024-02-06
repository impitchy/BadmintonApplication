import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_badminton/screens/manu.dart';
import 'package:train_badminton/screens/signin.dart';
import 'package:train_badminton/screens/total.dart';

class Training extends StatefulWidget {
  @override
  
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  Color playButtonColor = Color(0xFFF55050);
  Color stopButtonColor = Color(0xFFF55050);

  ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  int currentIndex = 0;
  int totalButtons = 7;
  List<Color> buttonColors =
      List.generate(7, (index) => Color.fromARGB(255, 125, 73, 73));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'การเล่น',
            style: TextStyle(
              color: const Color.fromARGB(
                  255, 255, 255, 255), // สีข้อความใน Appbar
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFC63D2F),
        ),
      ),
      body: Container(
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
                      -20.0,
                    ),
                    child: CustomPaint(
                      size: Size(350, 390),
                      painter:
                          BadmintonCourtPainter(buttonColors: buttonColors),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (!isPlaying.value) {
                          startRunning();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: playButtonColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.play_arrow),
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        if (isPlaying.value) {
                          stopRunning();
                        }
                        showStopDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: stopButtonColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.stop),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalButtons, (index) {
                    return Container(
                      margin: EdgeInsets.all(1.0),
                      width: 5.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: buttonColors[index],
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showInfoDialog(context);
        },
        child: Icon(Icons.question_mark),
        backgroundColor: Color(0xFFE25E3E),
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
                MaterialPageRoute(builder: (context) => Signin()),
              );
              break;
          }
        },
      ),
    );
  }

  void startRunning() {
    isPlaying.value = true;
    int delay = 1000;
    runNextButton(delay);
  }

  void stopRunning() {
    isPlaying.value = false;
  }

  void runNextButton(int delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      if (isPlaying.value) {
        handleButtonPress();
        currentIndex++;

        if (currentIndex < totalButtons) {
          runNextButton(delay);
        } else {
          currentIndex = 0;
          isPlaying.value = false;

          // Turn off the lights when all buttons are pressed
          turnOffLights();
        }
      }
    });
  }

  void turnOffLights() {
    // Reset all button colors to the original color
    for (int i = 0; i < totalButtons; i++) {
      changeButtonColor(i, Color.fromARGB(255, 125, 73, 73));
    }
  }

  void handleButtonPress() {
    if (currentIndex > 0) {
      // Reset the color of the previous button (Button 6)
      changeButtonColor(currentIndex - 1, Color.fromARGB(255, 125, 73, 73));
    }

    // Change the color of the current button (Button 6)
    changeButtonColor(currentIndex, Color.fromARGB(255, 255, 0, 0));

    if (currentIndex == totalButtons - 1) {
      // Stop the game when the last button (Button 7) is reached
      isPlaying.value = false;
    } else {
      // Change the color of the next button (Button 7)
      changeButtonColor(currentIndex + 1, Color.fromARGB(255, 255, 0, 0));
    }
  }

  void changeButtonColor(int index, Color color) {
    setState(() {
      buttonColors[index] = color;
    });
  }

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('วิธีในการเล่น',
              style:
                  GoogleFonts.maitree(color: Color.fromARGB(255, 218, 50, 7))),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    '1.กด Play และดูตามไฟสัญาณ จากนั้นกับมาที่ปุ่มเซ็นเตอร์ตรงกลาง',
                    style:
                        GoogleFonts.maitree(color: Color.fromRGBO(0, 0, 0, 1))),
                Text('2.กด Stop เพื่อหยุดเล่น',
                    style: GoogleFonts.maitree(
                        color: const Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  Text('ปิด', style: GoogleFonts.maitree(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFE25E3E)),
              ),
            ),
          ],
        );
      },
    );
  }

  void showStopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('หยุดเกมแล้ว',
              style: GoogleFonts.maitree(
                  color: const Color.fromARGB(255, 243, 33, 33))),
          content: Text('กรุณาเลือกทำต่อ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('เล่นอีกครั้ง',
                  style: GoogleFonts.maitree(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFE25E3E)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Total()),
                );
              },
              child: Text('ผลรวมสถิติ',
                  style: GoogleFonts.maitree(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFE25E3E)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BadmintonCourtPainter extends CustomPainter {
  List<Color> buttonColors;

  BadmintonCourtPainter({required this.buttonColors});

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

    for (int i = 0; i < buttonColors.length; i++) {
      final buttonPaint = Paint()
        ..color = buttonColors[i]
        ..style = PaintingStyle.fill;

      double buttonX;
      double buttonY;

      if (i % 3 == 0) {
        buttonX = size.width / 40;
        buttonY = size.height / 4 * (i ~/ 3 + 1);
      } else if (i % 3 == 1) {
        buttonX = size.width / 2;
        buttonY = size.height / 2;
      } else {
        buttonX = size.width - size.width / 40;
        buttonY = size.height / 4 * (i ~/ 3 + 1);
      }

      canvas.drawCircle(Offset(buttonX, buttonY), 16.0, buttonPaint);
    }

    final extraButtonPaint = Paint()
      ..color = buttonColors.last
      ..style = PaintingStyle.fill;

    double extraButtonX = size.width - size.width / 40;
    double extraButtonY = size.height / 4 * (buttonColors.length ~/ 3 + 1);
    canvas.drawCircle(
        Offset(extraButtonX, extraButtonY), 16.0, extraButtonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
