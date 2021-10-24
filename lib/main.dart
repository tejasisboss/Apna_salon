import 'dart:convert';
import 'package:apna_salon/screens/login.dart';
import 'package:apna_salon/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<String> get tokenOrEmpty async {
    var jwt = await storage.read(key: "token");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apna Salon',
      theme: ThemeData(
        backgroundColor: Colors.white54,
        scaffoldBackgroundColor: Colors.white54,
        appBarTheme: AppBarTheme(
          color: const Color.fromRGBO(128, 0, 0, 1.0),
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: tokenOrEmpty,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data != "") {
            var str = snapshot.data;
            var jwt = str.split(".");

            if (jwt.length != 3) {
              return Login();
            } else {
              var payload = json.decode(
                  ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                  .isAfter(DateTime.now())) {
                return NavScreen();
              } else {
                return Login();
              }
            }
          } else {
            return Login();
          }
        },
      ),
      //home: Login(),
    );
  }
}
