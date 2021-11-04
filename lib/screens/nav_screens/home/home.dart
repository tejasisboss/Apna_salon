import 'package:apna_salon/models/salondetails.dart';
import 'package:apna_salon/screens/nav_screens/home/homehelpers.dart';
import 'package:apna_salon/screens/notifications.dart';
import 'package:apna_salon/screens/scrallable_image.dart';
import 'package:apna_salon/screens/tab_screens/employee_list.dart';
import 'package:apna_salon/screens/tab_screens/reviews_list.dart';
import 'package:apna_salon/screens/tab_screens/service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _showscreen = 0;
  Future<List<SalonDetails>> currentsalon;
  SalonDetails salonDetails;
  //Future<String> currentsalon;

  //Future<List<SalonDetails>> fetchSalonDetails() async {
  Future fetchSalonDetails() async {
    //Future<String> fetchSalonDetails() async {
    var token = await storage.read(key: 'token');
    var url = Uri.parse('https://test-salon-api.herokuapp.com/api/salon/info');
    var response = await http.get(url, headers: {
      'token': token,
    });
    print('This is details body: ${response.body}');
    print('This is SalonDetails: ${response.statusCode}');
    if (response.statusCode == 200) {
      var _salonInJson = json.decode(response.body);
      print('json data: $_salonInJson');
      salonDetails = SalonDetails(
        name: _salonInJson['name'],
        desc: _salonInJson['description'],
      );

      /*  List _salondetails = List<SalonDetails>.from(
        _salonInJson.map(
          (x) => SalonDetails.fromJson(x),
        ),
      ); */
      //print("Salons data: $_salondetails");
      //return _salondetails;
      return salonDetails;
    } else if (response.statusCode == 404) {
      throw Exception('No Details');
      print('SD: 404');
    } else {
      throw Exception('Failed to load Details');
      print('SD: Error');
    }
  }

  @override
  void initState() {
    super.initState();
    //currentsalon = fetchSalonDetails();
    //fetchSalonDetails();
  }

  final screens = [
    ServicesScreen(),
    EmployeeList(),
    ReviewList(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Apna Salon'),
        actions: [
          GestureDetector(
            onTap: () {
              print('notifications');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsList()));
            },
            child: Icon(
              Icons.notifications,
              size: 32,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: (size.width * 0.03),
              vertical: (size.height * 0.018),
            ),
            child: Text(
              '5',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchSalonDetails(),
        builder: (context, snapshot) => snapshot.data == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: (size.width * 0.06),
                      vertical: (size.height * 0.01),
                    ),
                    child: Sliderimg(),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: (size.width * 0.001),
                          vertical: (size.height * 0.001),
                        ),
                        child: Text(
                          '#1',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topCenter,
                        child: Center(
                          child: Text(
                            //'The Royal Salon',
                            snapshot.data.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF990F02),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('editName');
                          Provider.of<HomeHelpers>(context, listen: false)
                              .editSalonName(context);
                        },
                        child: Icon(
                          Icons.edit_rounded,
                          color: Colors.black12,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white54,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: (size.width * 0.01),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: (size.width * 0.01),
                        ),
                        child: Text(
                          'A clean area with a guaranteed safety precautionsand taking a good care regarding the covid guidelines.Moreover, we guarantee the best service in town with the finest artists.',
                          //snapshot.data.desc,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF704241),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5.0,
                        child: GestureDetector(
                          onTap: () {
                            print('editDesc');
                            Provider.of<HomeHelpers>(context, listen: false)
                                .editSalonDesc(context);
                          },
                          child: Icon(
                            Icons.edit_rounded,
                            color: Colors.black12,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showscreen = 0;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Service',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red[800],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showscreen = 1;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Employee',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red[800],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showscreen = 2;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Review',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red[800],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    height: size.height * 0.35,
                    margin: EdgeInsets.symmetric(
                      horizontal: (size.width * 0.01),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: screens[_showscreen],
                  )
                ],
              ),
      ),
    );
  }
}
