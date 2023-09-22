class SignUpModel {
  String email;
  String name;
  String password;
  bool isVerified;

  SignUpModel({
    required this.email,
    required this.name,
    required this.isVerified,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'isVerified': isVerified,
    };
  }

  SignUpModel copyWith({
    String? email,
    String? name,
    String? password,
    bool? isVerified,
  }) {
    return SignUpModel(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
