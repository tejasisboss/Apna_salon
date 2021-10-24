class Address {
  String address;
  String city;
  String pincode;
  String lat;
  String lng;

  Address({
    this.address,
    this.city,
    this.pincode,
    this.lat,
    this.lng,
  });

  String citygetter() {
    return this.city;
  }
}
