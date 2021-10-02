import 'package:flutter/material.dart';

import 'nav_screens/home.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;

  final tabs = [
    Home(),
    Center(
      child: Text(
        'Booking',
        style: TextStyle(fontSize: 30),
      ),
    ),
    Center(
      child: Text(
        'Payment',
        style: TextStyle(fontSize: 30),
      ),
    ),
    Center(
      child: Text(
        'Accounts',
        style: TextStyle(fontSize: 30),
      ),
    )
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
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white54,
        selectedItemColor: Colors.blue[700],
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Bookings",
            icon: Icon(Icons.book_sharp),
          ),
          BottomNavigationBarItem(
            label: "Payment",
            icon: Icon(Icons.payment_outlined),
          ),
          BottomNavigationBarItem(
            label: "Accounts",
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
