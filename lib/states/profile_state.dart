import 'package:equatable/equatable.dart';
import 'package:musix_admin/utils/utils.dart';

import '../models/models.dart';

class ProfileState extends Equatable {
  final Status status;
  final List<Profile> profiles;
  final String? error;

  const ProfileState({
    required this.status,
    required this.profiles,
    this.error,
  });

  ProfileState copyWith({
    Status? status,
    List<Profile>? profiles,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profiles: profiles ?? this.profiles,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        profiles,
        error,
      ];
}
