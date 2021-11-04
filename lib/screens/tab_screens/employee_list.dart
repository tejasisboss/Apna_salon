import 'package:apna_salon/models/employee.dart';
import 'package:apna_salon/screens/addscreens/employeeaddform.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  Future<List<Employee>> currentEmployeeList;
  //List<Employee> currentEmployeeList;
  int code;

  Future<List<Employee>> fetchEmployeeList() async {
    var token = await storage.read(key: 'token');
    var url =
        Uri.parse('https://test-salon-api.herokuapp.com/api/salon/employee');
    var response = await http.get(url, headers: {
      "token":
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNmM0NzM5MWY4NzEyMDAxNjQ3MzUyOCIsIm5hbWUiOiJkdW1teSBzYWxvbiIsInBob25lIjoiOTk5OTk5OTk5OSIsImlhdCI6MTYzNTYwOTEwNiwiZXhwIjoxNjM1NjEwOTA2fQ.vUZTwiR6bKRE1NS8gXofHTorHE4BbJ_MWqhZNjkfzHw',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List employeesInJson = json.decode(response.body);
      List _currentemployee = List<Employee>.from(
        employeesInJson.map(
          (x) => Employee.fromJson(x),
        ),
      );
      return _currentemployee;
    } else if (response.statusCode == 404) {
      throw Exception('No Employees');
    } else {
      throw Exception('Failed to load Employees');
    }
  }

  @override
  void initState() {
    super.initState();

    currentEmployeeList = fetchEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: currentEmployeeList,
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data[index];
                  return ListTile(
                    title: Text('${item.firstname} ${item.lastname}'),
                    leading: Icon(Icons.person),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        //To Delete
                      },
                    ),
                  );
                },
              )
            : snapshot.hasError
                ? Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        //"No current Orders.",
                        " ${snapshot.error.toString().replaceAll("Exception: ", " ")}",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                : snapshot.data == null
                    ? Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "No current Employees.",
                          //" ${snapshot.error.toString().replaceAll("Exception: ", " ")}",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: Align(
        child: FloatingActionButton(
          mini: true,
          onPressed: () {
            print('yes');
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                      child: EmployeeAddForm(),
                    ),
                  );
                });
            // Add your onPressed code here!
          },
          splashColor: Colors.white,
          child: const Icon(Icons.add),
          backgroundColor: Colors.white54,
        ),
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}
