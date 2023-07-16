import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String password;
  final String token;
  final String name;

  const User({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.token,
  });

  User copyWith({
    String? id,
    String? username,
    String? password,
    String? name,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        name,
        token,
      ];
}
