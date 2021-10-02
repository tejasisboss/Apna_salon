import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Sliderimg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //Function to Change images
      },
      child: Container(
        //height: size.height * 0.20,
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ].map((e) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      child: e,
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
