import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_badminton/screens/activity.dart';
import 'package:train_badminton/screens/home.dart';
import 'package:train_badminton/screens/training.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manu(),
    );
  }
}

class Manu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'หน้าแรก',
            style: TextStyle(
              color: const Color.fromARGB(
                  255, 255, 255, 255), // สีข้อความใน Appbar
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFC63D2F),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: ListView(
            children: [
              Container(
                height: 250,
                child: Transform.scale(
                  scale:
                      1.2, // 1.0 คือขนาดปกติ, ค่าที่มากกว่า 1 จะทำให้ขยายใหญ่ขึ้น
                  child: Image.asset(
                    'images/photo1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 0),
              Padding(
                padding:
                    const EdgeInsets.all(20), // ปรับค่า padding ตามที่ต้องการ
                child: Text(
                  'เลือกเมนูที่ต้องการใช้',
                  style: GoogleFonts.maitree(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Training()),
                        );
                      },
                      child: Image.asset(
                        'images/photoplay.png',
                        height: 400,
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Activity()),
                        );
                      },
                      child: Image.asset(
                        'images/photoavg.png',
                        height: 400,
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
              // นำทางไปยังหน้า Play (เปลี่ยนตามที่คุณต้องการ)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Training()),
              );
              break;
            case 2:
              // นำทางไปยังหน้า Log Out (เปลี่ยนตามที่คุณต้องการ)
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
