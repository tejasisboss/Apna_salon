class SalonDetails {
  final String name, desc, gender;
  List images;

  SalonDetails({this.name, this.desc, this.gender, this.images});

  factory SalonDetails.fromJson(Map<String, dynamic> json) {
    return SalonDetails(
      name: json['name'],
      desc: json['description'],
      gender: json['gender'],
      images: json['images'],
    );
  }
  String get getName => name;
  List<dynamic> get getImages => images;
}
