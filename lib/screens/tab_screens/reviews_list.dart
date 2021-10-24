import 'package:apna_salon/models/reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewList extends StatefulWidget {
  const ReviewList({Key key}) : super(key: key);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  Future<List<Reviews>> currentreviews;

  Future<List<Reviews>> fetchReviewsList() async {
    var token = await storage.read(key: 'token');
    var url = Uri.parse('https://apna-salon-api.herokuapp.com/api/review');
    var response = await http.get(url, headers: {
      'token': token,
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('');
      List reviewsInJson = json.decode(response.body);
      List _currentreviews = List<Reviews>.from(
        reviewsInJson.map(
          (x) => Reviews.fromJson(x),
        ),
      );
      return _currentreviews;
    } /* else if (response.statusCode == 404) {
      throw Exception('No Employees');
    } else {
      throw Exception('Failed to load Orders');
    } */
  }

  @override
  void initState() {
    super.initState();
    currentreviews = fetchReviewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: currentreviews,
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
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(item.name),
                            RatingBar.builder(
                              initialRating: item.star,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              allowHalfRating: true,
                              onRatingUpdate: (val) {},
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        Text(item.comment),
                      ],
                    ),
                  );
                  /* ListTile(
              title: Text('Reviews #$index'),
              leading: Icon(Icons.message),
              trailing: IconButton(
                icon: Icon(Icons.reply),
                onPressed: () {
                  //To Delete
                },
              ),
            ); */
                },
              )
            : snapshot.hasError
                ? Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      //"No current Reviews.",
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
                          "No current Reviews.",
                          //" ${snapshot.error.toString().replaceAll("Exception: ", " ")}",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
