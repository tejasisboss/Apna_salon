import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../main.dart';

class EmployeeAddForm extends StatefulWidget {
  @override
  _EmployeeAddFormState createState() => _EmployeeAddFormState();
}

class _EmployeeAddFormState extends State<EmployeeAddForm> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController openTimeController = new TextEditingController();
  TextEditingController closeTimeController = new TextEditingController();

  TimeOfDay picked;

  bool _isLoading = false;

  addEmployee() async {
    print("in addEmployee");
    var token = await storage.read(key: 'token');
    print('i am in addemployee');
    dynamic jsonData;
    var url = Uri.parse(
        'https://test-salon-api.herokuapp.com/api/salon/employee/add');
    var response = await http.post(url, body: {
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "desc": descController.text,
      //"password": passwordController.text,
    }, headers: {
      'token': token,
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonData = json.decode(json.encode(response.body));
      setState(() {
        _isLoading = false;
      });
    } else {
      print(response.body);
      print(response.statusCode);
      setState(() {
        _isLoading = false;
      });
      dialogBox(context, "An Error Occurred", "Please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  decoration: textFieldInputDecoration('First Name'),
                ),
                SizedBox(height: (size.height * 0.02)),
                TextFormField(
                  controller: lastNameController,
                  decoration: textFieldInputDecoration('Last Name'),
                ),
                SizedBox(height: (size.height * 0.02)),
                Container(
                  child: TextFormField(
                    maxLines: 3,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    maxLengthEnforced: true,
                    maxLength: 100,
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
                          'Start Time: ',
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
                        Text('End Time: ',
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
                              print('End time');
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
                SizedBox(height: (size.height * 0.04)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLoading = true;
                    });
                    addEmployee();
                    Navigator.pop(context);
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
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
