
class User {
  final int id;
  final String firstName;
  final String? lastName;
  final String email;
  final String? image;

  User({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
    );
  }
}