class Booking {
  String orderName;
  int amount;
  DateTime dateOfBooking;

  Booking({
    this.orderName,
    this.amount,
    this.dateOfBooking,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      orderName: json['orderName'],
      amount: json['amount'],
      dateOfBooking: json['dateOfBooking'],
    );
  }
}
