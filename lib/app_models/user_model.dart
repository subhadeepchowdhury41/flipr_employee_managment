class User {
  final String id;
  final String username;
  final String profession;
  final String email;
  final String contactNo;
  final String department;
  final String joiningDate;
  final bool isActive;
  final String password;

  User({
    required this.id,
    required this.username,
    required this.profession,
    required this.email,
    required this.contactNo,
    required this.department,
    required this.joiningDate,
    required this.isActive,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      username: data['username'],
      id: data['_id'],
      profession: data['profession'],
      email: data['email'],
      contactNo: data['contactNo'],
      joiningDate: data['joiningDate'],
      department: data['department'],
      isActive: data['active'],
      password: data['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'profession': profession,
      'email': email,
      'contactNo': contactNo,
      'department': department,
      'joiningDate': joiningDate,
      'isActive': isActive,
    };
  }
}
