import 'dart:convert';
import 'package:apna_salon/models/address.dart';
import 'package:apna_salon/screens/after_registration.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:apna_salon/screens/login.dart';
import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController salonNameController = new TextEditingController();
  TextEditingController ownerNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController openTimeController = new TextEditingController();
  TextEditingController closeTimeController = new TextEditingController();
  TextEditingController numberOfSlotsController = new TextEditingController();

  bool _isLoading = false;
  String dropdownValue;
  Address address;
  TimeOfDay picked;

  signUp() async {
    print('i am in register');
    dynamic jsonData;
    var url =
        Uri.parse('https://test-salon-api.herokuapp.com/api/salon/register');
    var response = await http.post(url, body: {
      "name": salonNameController.text,
      "ownername": ownerNameController.text,
      "email": emailController.text,
      "description": descController.text,
      "phone": phoneController.text,
      "address": address.citygetter(),
      "password": passwordController.text,
      "gender": dropdownValue,
      "opentime": openTimeController.text,
      "closetime": closeTimeController.text,
    });
    print('body- ${response.body}');
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonData = json.decode(json.encode(response.body));
      setState(() {
        _isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => AfterRegistration()),
            (Route<dynamic> route) => false);
      });
    } else {
      print(response.body);
      setState(() {
        _isLoading = false;
      });
      dialogBox(context, "An Error Occurred", "Email already exists");
    }
  }

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
              SizedBox(height: (size.height * 0.03)),
              Text(
                "Become Partner",
                style: TextStyle(
                  color: Color.fromRGBO(128, 0, 0, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: (size.height * 0.02)),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: salonNameController,
                      decoration: textFieldInputDecoration('Salon Name'),
                    ),
                    SizedBox(height: (size.height * 0.02)),
                    TextFormField(
                      controller: ownerNameController,
                      decoration: textFieldInputDecoration('Owner Name'),
                    ),
                    SizedBox(height: (size.height * 0.02)),
                    TextFormField(
                      controller: emailController,
                      decoration: textFieldInputDecoration('Email ID'),
                    ),
                    SizedBox(height: (size.height * 0.02)),
                    TextFormField(
                      controller: phoneController,
                      decoration: textFieldInputDecoration('Mobile No'),
                    ),
                    SizedBox(height: (size.height * 0.02)),
                    TextFormField(
                      controller: cityController,
                      decoration: textFieldInputDecoration('City'),
                    ),
                    SizedBox(height: (size.height * 0.02)),
                    DropdownButton(
                      hint: Text("Salon Type"),
                      value: dropdownValue,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black54,
                      ),
                      iconSize: 36,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.black54,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items:
                          <String>["Men's", "Women's", "Unisex"].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Container(
                      child: TextFormField(
                        maxLines: 5,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200)
                        ],
                        maxLengthEnforced: true,
                        maxLength: 200,
                        controller: descController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add A Descrition',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: (size.height * 0.02)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Open Time: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextFormField(
                                onTap: () async {
                                  print('Start time');
                                  picked = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());

                                  if (picked != null) {
                                    setState(() {
                                      openTimeController.text =
                                          '${picked.hour}:${picked.minute}';
                                    });
                                  }
                                },
                                controller: openTimeController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'e.g. 06:00',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white10)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white10))),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Close Time: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextFormField(
                                onTap: () async {
                                  print('Close time');
                                  picked = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());

                                  if (picked != null) {
                                    setState(() {
                                      closeTimeController.text =
                                          '${picked.hour}:${picked.minute}';
                                    });
                                  }
                                },
                                controller: closeTimeController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'e.g. 10:00',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white10)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white10))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: (size.height * 0.02)),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: textFieldInputDecoration('Password'),
                    ),
                    SizedBox(height: (size.height * 0.04)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoading = true;
                          address = new Address(city: cityController.text);
                        });
                        signUp();
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
                          'Submit',
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
                          "Already have account?",
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
                                    builder: (context) => Login()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'LogIn',
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
              SizedBox(height: (size.height * 0.03)),
            ],
          ),
        ),
      ),
    );
  }
}
