import 'package:apna_salon/screens/scrallable_image.dart';
import 'package:apna_salon/screens/tab_screens/employee_list.dart';
import 'package:apna_salon/screens/tab_screens/reviews_list.dart';
import 'package:apna_salon/screens/tab_screens/service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _showscreen = 0;

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
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: (size.width * 0.03),
              vertical: (size.height * 0.01),
            ),
            child: Text(
              '5',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
      body: Column(
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
                  'The Royal Salon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF990F02),
                  ),
                )),
              ),
            ],
          ),
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
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFF704241),
              ),
            ),
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
    );
  }
}
