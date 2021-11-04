import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Sliderimg extends StatefulWidget {
  @override
  State<Sliderimg> createState() => _SliderimgState();
}

class ImageConfig {
  String source;
  String path;

  ImageConfig({this.source, this.path});
}

class _SliderimgState extends State<Sliderimg> {
  List<ImageConfig> imgList = [
    ImageConfig(
        source: "http",
        path:
            'https://cdn.pixabay.com/photo/2016/04/15/08/04/strawberries-1330459_960_720.jpg'),
  ];
  List<Widget> imageSliders;
  List<ImageConfig> resultList;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgList.add(ImageConfig(source: "file", path: pickedFile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    imageSliders = imgList
        .map(
          (item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      item.source == "http"
                          ? Image.network(item.path,
                              fit: BoxFit.cover, width: 1000.0)
                          : Image.file(File(item.path),
                              fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        )
        .toList();

    return GestureDetector(
      onTap: () {
        //Function to Change images
        print('imageslider');
        getImage();
        //pickImages();
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
              //itemCount: imgUrls.length,
              items: imageSliders,
            ),
          ],
        ),
      ),
    );
  }
}
