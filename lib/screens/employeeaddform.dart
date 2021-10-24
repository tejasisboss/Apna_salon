import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../main.dart';

class EmployeeAddForm extends StatefulWidget {
  @override
  _EmployeeAddFormState createState() => _EmployeeAddFormState();
}

class _EmployeeAddFormState extends State<EmployeeAddForm> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  //TextEditingController passwordController = new TextEditingController();

  bool _isLoading = false;

  addEmployee() async {
    print("in addEmployee");
    var token = await storage.read(key: 'token');
    print('i am in addemployee');
    dynamic jsonData;
    var url = Uri.parse(
        'https://apna-salon-api.herokuapp.com/api/salon/employee/add');
    var response = await http.post(url, body: {
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "phone": phoneController.text,
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
      dialogBox(context, "An Error Occurred", "Email already exists");
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
                TextFormField(
                  controller: phoneController,
                  decoration: textFieldInputDecoration('Mobile No'),
                ),
                SizedBox(height: (size.height * 0.02)),
                /* TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: textFieldInputDecoration('Password'),
                ), */
                SizedBox(height: (size.height * 0.04)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLoading = true;
                    });
                    addEmployee();
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
