class SignUpModel {
  String email;
  String phone;
  String password;
  String name;

  SignUpModel({
    required this.email,
    required this.phone,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'name': name,
    };
  }
}
