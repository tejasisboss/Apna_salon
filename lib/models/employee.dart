class Employee {
  String firstname, lastname, phone, description, password;
  int employeeid;
  bool isActive;

  Employee({
    this.employeeid,
    this.firstname,
    this.description,
    this.lastname,
    this.phone,
    this.password,
  });
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}
