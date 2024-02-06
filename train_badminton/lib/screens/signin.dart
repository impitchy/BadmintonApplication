import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_badminton/screens/manu.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _obscureText = true;
  final _formKey =
      GlobalKey<FormState>(); // เพิ่ม GlobalKey เพื่อให้เข้าถึง form

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateEmail(String? value) {
    // ใส่โค้ดตรวจสอบรูปแบบอีเมล์ที่ถูกต้อง
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกอีเมล์';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'รูปแบบอีเมล์ไม่ถูกต้อง';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    // ใส่โค้ดตรวจสอบรหัสผ่าน
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกรหัสผ่าน';
    } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'รหัสผ่านต้องประกอบด้วยตัวเลข 6 ตัวเท่านั้น';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6F4EB),
      ),
      body: Container(
        color: Color(0xFFFF6F4EB),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // กำหนด key ให้ form
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Image.asset(
                      'images/logo7.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(bottom: 80.0),
                    child: Text(
                      'ลงชื่อเข้าใช้เพื่อเข้าสู่ระบบ',
                      style: GoogleFonts.maitree(
                        fontSize: 25,
                        color: Color(0xFFF3F2305),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      width: 350,
                      height: 60,
                      child: TextFormField(
                        validator:
                            _validateEmail, // เพิ่ม validate function ที่นี่
                        style: GoogleFonts.maitree(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        decoration: InputDecoration(
                          hintText: 'กรอกอีเมล์ที่นี่',
                          labelText: 'อีเมล์',
                          labelStyle: TextStyle(
                            color: Color(0xFFF6C5F5B),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xFFF4F4A45),
                            size: 30,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          filled: true,
                          fillColor: Color(0xFFFF5F7F8),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      width: 350,
                      height: 60,
                      child: TextFormField(
                        validator:
                            _validatePassword, // เพิ่ม validate function ที่นี่
                        style: GoogleFonts.maitree(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        decoration: InputDecoration(
                          hintText: 'กรอกรหัสผ่านที่นี่',
                          labelText: 'รหัสผ่าน',
                          labelStyle: TextStyle(
                            color: Color(0xFFF4F4A45),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFFF4F4A45),
                            size: 30,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          filled: true,
                          fillColor: Color(0xFFFF5F7F8),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // เพิ่มการตรวจสอบ validate ก่อนทำการ login
                      if (_formKey.currentState!.validate()) {
                        // ทำตามปกติเมื่อผ่านการตรวจสอบ
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Manu(),
                          ),
                        ).then((_) => print('to Activity'));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFC63D2F),
                      onPrimary: Color(0xFFF9F9F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      minimumSize: Size(250, 50),
                    ),
                    child: Text(
                      'เข้าสู่ระบบ',
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
