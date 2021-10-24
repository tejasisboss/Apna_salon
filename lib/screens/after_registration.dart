import 'package:apna_salon/screens/login.dart';
import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AfterRegistration extends StatefulWidget {
  @override
  _AfterRegistrationState createState() => _AfterRegistrationState();
}

class _AfterRegistrationState extends State<AfterRegistration> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: (size.height * 0.04),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Registered Successfully",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Color.fromRGBO(128, 0, 0, 1.0),
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            Text(
              "Thank you for Registering with us. We at Apna Salon are very happy to have you as a partner. For further verifications one of our team members will contact You.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Color.fromRGBO(128, 0, 0, 1.0),
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
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
                  'Done',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "For more information and for any Query's about the process please press the bellow \"Contact Us\" button. ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Color.fromRGBO(128, 0, 0, 1.0),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                showContactUs(context);
              },
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
    );
  }
}
