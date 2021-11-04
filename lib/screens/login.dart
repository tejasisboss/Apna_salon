import 'dart:convert';
import 'package:apna_salon/main.dart';
import 'package:http/http.dart' as http;

import 'package:apna_salon/screens/nav_screen.dart';
import 'package:apna_salon/screens/register.dart';
import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

  bool _isLoading = false;

  signin(String username, String password) async {
    print("i am here");
    Map data = {'phone': username, 'password': password};
    dynamic jsonData;
    var response = await http.post(
        Uri.parse('https://test-salon-api.herokuapp.com/api/salon/login'),
        body: data);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonData = json.decode(json.encode(response.body));
      setState(() {
        _isLoading = false;
        if (response.body != null) {
          storage.write(key: 'token', value: response.body);
          //getUserData();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => NavScreen()),
              (Route<dynamic> route) => false);
        }
      });
    } else if (response.statusCode == 503) {
      setState(() {
        _isLoading = false;
      });
      dialogBox(context, "An Error Occurred",
          "Server is in maintanence. Please Try after some time.");
    } else {
      print(response.body);
      setState(() {
        _isLoading = false;
      });
      dialogBox(context, "An Error Occurred", "Enter the Correct Credentials");
    }
  }

  Future getUserData() async {
    var token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse('https://test-salon-api.herokuapp.com/api/salon'),
        headers: {
          'token': token,
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List detailsInJson = json.decode(response.body);
      print(detailsInJson);
      /* List<SalonDetails> salondata = [];
      for (var s in detailsInJson) {
        SalonDetails salonDetails = SalonDetails(s['name'], s['gender']);
        salondata.add(salonDetails);
      } */
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                            controller: usernameController,
                            decoration: textFieldInputDecoration(
                                'Email or Phone Number..'),
                          ),
                          SizedBox(height: (size.height * 0.04)),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: textFieldInputDecoration('Password'),
                          ),
                          SizedBox(height: (size.height * 0.04)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLoading = true;
                              });
                              storage.deleteAll();
                              print("login");
                              signin(usernameController.text,
                                  passwordController.text);
                              /*  Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavScreen())); */
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
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
                      onTap: () {
                        showContactUs(context);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 3),
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
