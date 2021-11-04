class Reviews {
  String id, customid, salonID, createdAt, updatedAt, comment;
  int star, v;

  Reviews(
      {this.id,
      this.customid,
      this.salonID,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.star,
      this.comment});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      id: json['_id'],
      customid: json['customerID'],
      salonID: json['salonID'],
      comment: json['comment'],
      star: json['star'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
