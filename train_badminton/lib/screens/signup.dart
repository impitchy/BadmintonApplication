import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_badminton/screens/signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกชื่อผู้ใช้';
    } else if (value.length > 6) {
      return 'ชื่อผู้ใช้ต้องไม่เกิน 6 ตัวอักษร';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกอีเมล์';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'รูปแบบอีเมล์ไม่ถูกต้อง';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกรหัสผ่าน';
    } else if (value.length > 6) {
      return 'รหัสผ่านต้องไม่เกิน 6 ตัวอักษร';
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
              key: _formKey,
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
                      'สร้างบัญชีใหม่เพื่อเข้าสู่ระบบ',
                      style: GoogleFonts.maitree(
                        fontSize: 25,
                        color: Color(0xFFF3F2305),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      width: 350,
                      height: 60,
                      child: TextFormField(
                        validator: _validateUsername,
                        style: GoogleFonts.maitree(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        decoration: InputDecoration(
                          hintText: 'กรอกชื่อผู้ใช้ที่นี่',
                          labelText: 'ชื่อผู้ใช้',
                          labelStyle: TextStyle(
                            color: Color(0xFFF4F4A45),
                          ),
                          prefixIcon: Icon(
                            Icons.face,
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
                        validator: _validateEmail,
                        style: GoogleFonts.maitree(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        decoration: InputDecoration(
                          hintText: 'กรอกอีเมล์ที่นี่',
                          labelText: 'อีเมล์',
                          labelStyle: TextStyle(
                            color: Color(0xFFF4F4A45),
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
                        validator: _validatePassword,
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
                            builder: (context) => Signin(),
                          ),
                        ).then((_) => print('to Activity'));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFE25E3E),
                      onPrimary: Color(0xFFF9F9F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      minimumSize: Size(250, 50),
                    ),
                    child: Text(
                      'สร้างบัญชี',
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
