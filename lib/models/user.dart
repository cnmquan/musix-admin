import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String password;
  final String token;
  final String name;

  const User({
    required this.username,
    required this.password,
    required this.name,
    required this.token,
  });

  User copyWith({
    String? username,
    String? password,
    String? name,
    String? token,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        name,
        token,
      ];
}
