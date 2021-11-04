import 'package:apna_salon/models/service_model.dart';
import 'package:apna_salon/screens/addscreens/serviceaddform.dart';
import 'package:apna_salon/widgets/inside_list.dart';
import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../main.dart';
import '../addscreens/employeeaddform.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  Future<List<Service>> currentservice;

  Future<List<Service>> fetchServiceList() async {
    var token = await storage.read(key: 'token');
    var url =
        Uri.parse('https://test-salon-api.herokuapp.com/api/salon/services');
    var response = await http.get(url, headers: {
      'token': token,
    });
    print('This is service body: ${response.body}');
    print(response.statusCode);
    if (response.statusCode == 200) {
      List serviceInJson = json.decode(response.body);
      List _currentservice = List<Service>.from(
        serviceInJson.map(
          (x) => Service.fromJson(x),
        ),
      );
      return _currentservice;
    } else if (response.statusCode == 404) {
      throw Exception('No Services');
    } else {
      throw Exception('Failed to load Services');
    }
  }

  @override
  void initState() {
    super.initState();
    currentservice = fetchServiceList();
  }

  @override
  Widget build(BuildContext context) {
    void _showservicelist() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: InsideList(),
            );
          });
    }

    return Scaffold(
      body: FutureBuilder(
        future: currentservice,
        builder: (context, snapshot) => snapshot.hasData
            ? snapshot.data.length == 0
            ? Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(50),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Text(
              "No current Service.",
              //" ${snapshot.error.toString().replaceAll("Exception: ", " ")}",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        )
            :  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data[index];
                      print('This is item:- $snapshot');
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.cost),
                        leading: Icon(Icons.person),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            //To Delete
                          },
                        ),
                        onTap: () {
                          _showservicelist();
                        },
                      );
                    },
                  )
            : snapshot.hasError
                ? Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        //"No current Service.",
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
                        child: Center(
                          child: Text(
                            "No current Service.",
                            //" ${snapshot.error.toString().replaceAll("Exception: ", " ")}",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
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
            Provider.of<ServiceAddForm>(context, listen: false)
                .serviceAddFormPage(context);
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
