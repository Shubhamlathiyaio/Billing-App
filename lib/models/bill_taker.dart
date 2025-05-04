import 'package:uuid/uuid.dart'; // Import the uuid package

class BillTaker {
  final String id;
  final String name;
  final String address;
  final String mobileNo;
  final String gstNo;

  // Constructor with an optional id parameter, which defaults to generating a new UUID
  BillTaker({
    String? id,
    required this.name,
    required this.address,
    required this.mobileNo,
    required this.gstNo,
  }) : id = id ?? Uuid().v4(); // Generate a unique ID if not provided

  // Factory method to create a BillTaker from a JSON map
  factory BillTaker.fromJson(Map<String, dynamic> json) {
    return BillTaker(
      id: json['id'] ?? Uuid().v4(), // Ensure we handle missing ID in JSON
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      gstNo: json['gstNo'] ?? '',
    );
  }

  // Method to convert a BillTaker instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'mobileNo': mobileNo,
      'gstNo': gstNo,
    };
  }
}
