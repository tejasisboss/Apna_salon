class Booking {
  int amount;
  DateTime dateOfBooking;

  Booking({
    this.amount,
    this.dateOfBooking,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      amount: json['amount'],
      dateOfBooking: json['dateOfBooking'],
    );
  }
}
