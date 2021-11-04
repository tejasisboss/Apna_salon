import 'package:apna_salon/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class BookingHistoryList extends StatefulWidget {
  BookingHistoryList({Key key}) : super(key: key);

  @override
  _BookingHistoryListState createState() => _BookingHistoryListState();
}

class _BookingHistoryListState extends State<BookingHistoryList> {
  Future<List<Booking>> previousBookings;

  Future<List<Booking>> fetchPreviousBookings() async {
    var token = await storage.read(key: 'token');
    var url = Uri.parse(
        'https://test-salon-api.herokuapp.com/api/salon/booking/complete');
    print(token);
    var response = await http.get(url, headers: {
      'token': token,
    });
    print('inside previous Bookings');
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List ordersInJson = json.decode(response.body);
      print(json.decode(response.body));
      List _completedOrders = List<Booking>.from(
        ordersInJson.map(
          (x) => Booking.fromJson(x),
        ),
      );
      //print(_completedOrders[1].timestamp);
      return _completedOrders;
    } else if (response.statusCode == 404) {
      //throw Exception('No previous completed order');
    } else {
      throw Exception('Failed to load Orders');
    }
  }

  @override
  void initState() {
    super.initState();
    previousBookings = fetchPreviousBookings();

    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: previousBookings,
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final booking = snapshot.data[index];
                  return ListTile(
                    title: Text('Name #$index'),
                    subtitle: Text('Service'),
                    trailing: Text(booking.amount),
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
                        child: Center(
                          child: Text(
                            "No current Completed bookings.",
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
