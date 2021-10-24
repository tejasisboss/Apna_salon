import 'package:apna_salon/models/employee.dart';
import 'package:apna_salon/screens/employeeaddform.dart';
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
    //Future<int> fetchEmployeeList() async {
    var token = await storage.read(key: 'token');
    var url =
        Uri.parse('https://apna-salon-api.herokuapp.com/api/salon/employee');
    var response = await http.get(url, headers: {
      'token': token,
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('');
      List employeesInJson = json.decode(response.body);
      List _currentemployee = List<Employee>.from(
        employeesInJson.map(
          (x) => Employee.fromJson(x),
        ),
      );
      setState(() {
        code = response.statusCode;
      });
      return _currentemployee;
    } else if (response.statusCode == 404) {
      //throw Exception('No Employees');
      setState(() {
        code = response.statusCode;
      });
    } else {
      //throw Exception('Failed to load Orders');
      setState(() {
        code = response.statusCode;
      });
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
                    child: Text(
                      //"No current Orders.",
                      " ${snapshot.error.toString().replaceAll("Exception: ", " ")}",
                      style: TextStyle(
                        fontSize: 20.0,
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
                context: context,
                builder: (context) {
                  return Container(
                    //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                    child: EmployeeAddForm(),
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
