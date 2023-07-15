import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String username;
  final String? email;
  final String? fullName;
  final String role;
  final bool enable;

  const Profile({
    required this.id,
    required this.username,
    this.email,
    this.fullName,
    required this.role,
    required this.enable,
  });

  Profile copyWith({
    String? id,
    String? username,
    String? email,
    String? fullName,
    String? role,
    bool? enable,
  }) {
    return Profile(
      id: id ?? this.id,
      username: username ?? this.username,
      role: role ?? this.role,
      enable: enable ?? this.enable,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        fullName,
        role,
        enable,
      ];
}
