import 'package:apna_salon/screens/nav_screen.dart';
import 'package:apna_salon/screens/register.dart';
import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: (size.height * 0.04),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              /* Text(
                "Welcom to Apna Salon",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ), */
              SizedBox(height: (size.height * 0.04)),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textFieldInputDecoration('Username'),
                    ),
                    SizedBox(height: (size.height * 0.04)),
                    TextFormField(
                      obscureText: true,
                      decoration: textFieldInputDecoration('Password'),
                    ),
                    SizedBox(height: (size.height * 0.04)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromRGBO(128, 0, 0, 1.0),
                          /* gradient: LinearGradient(colors: [
                                const Color.fromRGBO(128, 0, 0, 1.0),
                                const Color.fromRGBO(255, 255, 255, 1.0),
                              ]),*/
                        ),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: (size.height * 0.02)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New Here?",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Become Partner',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: (size.height * 0.02)),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
