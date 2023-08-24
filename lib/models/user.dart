import 'package:pop_capture/h.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  String zip;
  String token;
  Set<String> fav_images;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.zip,
      required this.token,
      required this.fav_images});

  factory User._fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id']!,
      name: map['name']!,
      email: map['email']!,
      password: map['password']!,
      zip: map['zip']!,
      token: map['token']!,
      fav_images: (map['fav_images']! as List<dynamic>)
          .map((e) => e.toString())
          .toSet(),
    );
  }

  factory User.fromJson(String source) => User._fromMap(jsonDecode(source));
}
