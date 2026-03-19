import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'student_personal_details.dart';

class StudentForm extends StatefulWidget {
  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final TextEditingController _phoneEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  
  String? _phoneEmailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _validatePhoneEmail(String value) {
    // Check if it's a valid Gmail email
    final emailRegex = RegExp(r'^[^@]+@gmail\.com$');
    if (emailRegex.hasMatch(value)) {
      return true;
    }
    
    // Check if it's a valid phone number (exactly 11 digits, starts with 09)
    final phoneRegex = RegExp(r'^09\d{9}$');
    if (phoneRegex.hasMatch(value)) {
      return true;
    }
    
    return false;
  }

  bool _validatePassword(String value) {
    if (value.length <= 5) {
      return false;
    }
    // Check if it has at least one number
    if (!RegExp(r'\d').hasMatch(value)) {
      return false;
    }
    return true;
  }

  void _validateConfirmPassword() {
    setState(() {
      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = null;
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = "Passwords do not match";
      } else {
        _confirmPasswordError = null;
      }
    });
  }

  void _handleNext() {
    setState(() {
      _phoneEmailError = null;
      _passwordError = null;
      _confirmPasswordError = null;

      if (_phoneEmailController.text.isEmpty) {
        _phoneEmailError = "Phone number (11 digits, starts with 09) or Gmail is required";
      } else if (!_validatePhoneEmail(_phoneEmailController.text)) {
        _phoneEmailError = "Enter a valid Gmail or phone number (11 digits, starts with 09)";
      }

      if (_passwordController.text.isEmpty) {
        _passwordError = "Password is required";
      } else if (!_validatePassword(_passwordController.text)) {
        _passwordError = "Password must be > 5 chars and contain a number";
      }

      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = "Please confirm your password";
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = "Passwords do not match";
      }

      if (_phoneEmailError == null && _passwordError == null && _confirmPasswordError == null) {
        // All validations passed - navigate to personal details
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentPersonalDetails()),
        );
      }
    });
  }

  @override
  void dispose() {
    _phoneEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF00ADEF),
              const Color.fromARGB(255, 23, 0, 231)
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Student Registration", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10,),
                  FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Create your account", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  controller: _phoneEmailController,
                                  decoration: InputDecoration(
                                    hintText: "Email or Phone number (11 digits, starts with 09)",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: _phoneEmailError,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: !_showPassword,
                                  decoration: InputDecoration(
                                    hintText: "Password (>5 chars, with number)",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: _passwordError,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword ? Icons.visibility : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  controller: _confirmPasswordController,
                                  obscureText: !_showConfirmPassword,
                                  onChanged: (_) => _validateConfirmPassword(),
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: _confirmPasswordError,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showConfirmPassword = !_showConfirmPassword;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1500), child: MaterialButton(
                          onPressed: _handleNext,
                          height: 50,
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )),
                        SizedBox(height: 40,),
                      ],
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
