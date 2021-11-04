class Service {
  String id, name;
  int ammount, v;

  Service({this.id, this.name, this.v, this.ammount});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      name: json['name'],
      ammount: json['ammount'],
      v: json['__v'],
    );
  }
}
