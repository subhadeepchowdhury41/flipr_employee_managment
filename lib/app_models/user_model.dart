class User {
  final String id;
  final String username;
  final String role;
  final String email;
  final String contactNo;
  final String department;
  final String joiningDate;

  User({required this.id,
    required this.username,
    required this.role,
    required this.email,
    required this.contactNo,
    required this.department,
    required this.joiningDate});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      username: data['username'],
      id: data['id'],
      role: data['role'],
      email: data['email'],
      contactNo: data['contactNo'],
      joiningDate: data['joiningDate'],
      department: data['department']
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}