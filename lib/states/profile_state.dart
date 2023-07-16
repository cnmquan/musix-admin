import 'package:equatable/equatable.dart';
import 'package:musix_admin/utils/utils.dart';

import '../models/models.dart';

class ProfileState extends Equatable {
  final String key;
  final Status status;
  final List<Profile> profiles;
  final String? error;

  const ProfileState({
    required this.key,
    required this.status,
    required this.profiles,
    this.error,
  });

  ProfileState copyWith({
    String? key,
    Status? status,
    List<Profile>? profiles,
    String? error,
  }) {
    return ProfileState(
      key: key ?? this.key,
      status: status ?? this.status,
      profiles: profiles ?? this.profiles,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        key,
        status,
        profiles,
        error,
      ];
}
