class Employee {
  String id;
  String name;
  String addressLine1;
  String city;
  String country;
  String zipCode;
  String email;

  Employee({
    required this.id,
    required this.name,
    required this.addressLine1,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.email,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'] ?? '',
      name: json['name'] ?? '', // Ensure field names match API response
      addressLine1: json['addressLine1'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      zipCode: json['zipCode'] ?? '', // Ensure field names match API response
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name, // Match the exact field names expected by the server
      'addressLine1': addressLine1,
      'city': city,
      'country': country,
      'zipCode': zipCode,
      'email': email,
    };
  }
}
