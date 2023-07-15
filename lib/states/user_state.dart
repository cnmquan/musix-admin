import 'package:equatable/equatable.dart';
import 'package:musix_admin/models/models.dart';
import 'package:musix_admin/utils/utils.dart';

class UserState extends Equatable {
  final Status status;
  final User? user;
  final String? error;

  const UserState({
    required this.status,
    this.user,
    this.error,
  });

  UserState copyWith({
    Status? status,
    User? user,
    String? error,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        error,
      ];
}
