import 'package:apna_salon/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class BookedList extends StatefulWidget {
  BookedList({Key key}) : super(key: key);

  @override
  _BookedListState createState() => _BookedListState();
}

class _BookedListState extends State<BookedList> {
  Future<List<Booking>> currentBookings;

  Future<List<Booking>> fetchReviewsList() async {
    var token = await storage.read(key: 'token');
    var url =
        Uri.parse('https://test-salon-api.herokuapp.com/api/salon/bookings');
    var response = await http.get(url, headers: {
      'token': token,
    });
    print('This is body: ${response.body}');
    print(response.statusCode);
    if (response.statusCode == 200) {
      List bookingsInJson = json.decode(response.body);
      List _currentbookings = List<Booking>.from(
        bookingsInJson.map(
          (x) => Booking.fromJson(x),
        ),
      );
      return _currentbookings;
    } else if (response.statusCode == 404) {
      throw Exception('No Bookings');
    } else {
      throw Exception('Failed to load Bookings');
    }
  }

  @override
  void initState() {
    super.initState();
    currentBookings = fetchReviewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: currentBookings,
        builder: (context, snapshot) => snapshot.hasData ? snapshot.data.length == 0
            ? Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(50),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Text(
              "No current Bookings.",
              //" ${snapshot.error.toString().replaceAll("Exception: ", " ")}",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        )
            :
            ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data[index];
                  return ListTile(
                    title: Text(item.orderName),
                    subtitle: Text(item.dateOfBooking),
                    trailing: Text(item.ammount),
                  );
                },
              )
            : snapshot.hasError
                ? Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        //"No current Bookings.",
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
                            "No current Bookings.",
                            //" ${snapshot.error.toString().replaceAll("Exception: ", " ")}",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
