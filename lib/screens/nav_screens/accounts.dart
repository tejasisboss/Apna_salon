import 'package:apna_salon/main.dart';
import 'package:apna_salon/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key key}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF990F02),
          title: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  //backgroundImage: _image,               //put your image here
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  'HiPartner',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 30,
                        color: Colors.red[900],
                      ),
                      SizedBox(
                        width: size.width * 0.10,
                      ),
                      Text(
                        'Need Help ?',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 30,
                        color: Colors.red[900],
                      ),
                      SizedBox(
                        width: size.width * 0.10,
                      ),
                      Text(
                        'Manage your booking',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 30,
                        color: Colors.red[900],
                      ),
                      SizedBox(
                        width: size.width * 0.10,
                      ),
                      Text(
                        'List of your Saloon',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 30,
                        color: Colors.red[900],
                      ),
                      SizedBox(
                        width: size.width * 0.10,
                      ),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 30,
                        color: Colors.red[900],
                      ),
                      SizedBox(
                        width: size.width * 0.10,
                      ),
                      Text(
                        'Privacy & Policy',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.09,
              ),
              GestureDetector(
                onTap: () async {
                  storage.delete(key: "token");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()),
                      (Route<dynamic> route) => false);
                },
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: AlignmentDirectional.topCenter,
                  height: 70.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[500],
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
