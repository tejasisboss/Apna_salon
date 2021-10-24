import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)));
}

Widget addbutton() {
  return Align(
    child: FloatingActionButton(
      mini: true,
      onPressed: () {
        // Add your onPressed code here!
      },
      splashColor: Colors.white,
      child: const Icon(Icons.add),
      backgroundColor: Colors.white54,
    ),
    alignment: Alignment.bottomCenter,
  );
}

dialogBox(BuildContext context, String title, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(title: Text(title), content: Text(text)),
  );
}

void showContactUs(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color.fromRGBO(128, 0, 0, 1.0),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "Get in Touch",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                height: 0.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                "We're here to listen to you!! Our dedicated team values every feedback and evolve to maximize our productivity and potential.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.mail_outline_rounded),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      "apnasaloninfo@gmail.com",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      "+91 8882228579",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
