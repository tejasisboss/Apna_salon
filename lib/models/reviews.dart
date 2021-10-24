class Reviews {
  String name, comment;
  int star;

  Reviews({this.name, this.star, this.comment});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      name: json['name'],
      star: json['star'],
      comment: json['comment'],
    );
  }
}
