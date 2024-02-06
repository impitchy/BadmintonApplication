import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_badminton/screens/signin.dart';
import 'package:train_badminton/screens/signup.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6F4EB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/logo7.png',
                    width: 1500,
                    height: 500,
                  ),
                  SizedBox(height: 20), // เพิ่มระยะห่างที่นี่
                  ElevatedButton(
                    onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signin()))
                        .then((_) => print('to Manu')),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFC63D2F),
                      onPrimary: Color(0xFFF9F9F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      minimumSize: Size(250, 53),
                    ),
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: GoogleFonts.maitree(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // เพิ่มระยะห่างที่นี่
                  ElevatedButton(
                    onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()))
                        .then((_) => print('to Manu')),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFE25E3E),
                      onPrimary: Color(0xFFF9F9F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      minimumSize: Size(250, 53),
                    ),
                    child: Text(
                      'สร้างบัญชีใหม่',
                      style: GoogleFonts.maitree(
                        fontSize: 23,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
