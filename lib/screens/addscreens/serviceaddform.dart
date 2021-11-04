import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import 'dart:convert';

class ServiceAddForm with ChangeNotifier {
  TextEditingController serviceNameController = new TextEditingController();
  TextEditingController ammountController = new TextEditingController();

  addService(BuildContext context) async {
    print("in addService");
    var token = await storage.read(key: 'token');
    print('i am in addService');
    dynamic jsonData;
    var url =
        Uri.parse('https://test-salon-api.herokuapp.com/api/salon/services');
    var response = await http.post(url, body: {
      "name": serviceNameController.text,
      "ammount": ammountController.text,
      //"password": passwordController.text,
    }, headers: {
      'token': token,
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonData = json.decode(json.encode(response.body));
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Added Successfull"),
            content: Text("Service is added!")),
      );
    } else {
      print(response.body);
      print(response.statusCode);
      /* showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("An Error Occurred"),
            content: Text("Please try again")),
      ); */
    }
  }

  serviceAddFormPage(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: serviceNameController,
                        decoration: textFieldInputDecoration('Service Name'),
                      ),
                      SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.02)),
                      TextFormField(
                        controller: ammountController,
                        decoration: textFieldInputDecoration('Service Cost'),
                      ),
                      SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.04)),
                      GestureDetector(
                        onTap: () {
                          addService(context);
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
          ),
        );
      },
    );
  }
}
