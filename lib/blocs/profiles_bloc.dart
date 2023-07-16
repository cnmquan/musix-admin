import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/actions/actions.dart';
import 'package:musix_admin/blocs/user_bloc.dart';
import 'package:musix_admin/repos/profile_repo.dart';
import 'package:musix_admin/states/states.dart';

import '../utils/utils.dart';

class ProfilesBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfilesBloc({
    required ProfileState initialState,
    required this.userBloc,
    required this.profileRepo,
  }) : super(initialState) {
    userBloc.stream.listen((state) {
      if (state.user?.token != null) {
        token = state.user?.token;
      }
    });
    on<LoadProfilesEvent>(_loadProfiles);
    on<SetProfileAdminEvent>(_setProfileAdmin);
    on<DisableProfileEvent>(_disableProfile);
  }

  final UserBloc userBloc;
  final ProfileRepo profileRepo;
  String? token;

  FutureOr<void> _loadProfiles(
      LoadProfilesEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      key: 'Global',
      status: Status.loading,
    ));
    try {
      final profiles = await profileRepo.getProfiles(token!);
      emit(state.copyWith(
        status: Status.success,
        profiles: profiles,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));
    }

    emit(state.copyWith(status: Status.idle));
  }

  FutureOr<void> _setProfileAdmin(
      SetProfileAdminEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
      key: 'SetAdmin',
    ));

    try {
      final profile = await profileRepo.createAdmin(
        token: token!,
        username: event.username,
        password: event.password,
        name: event.name,
      );
      final profiles = state.profiles;
      profiles.add(profile);
      emit(state.copyWith(
        status: Status.success,
        profiles: profiles,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));
    }

    emit(state.copyWith(status: Status.idle, key: 'Global'));
  }

  FutureOr<void> _disableProfile(
      DisableProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
    ));
    try {
      final profile = await profileRepo.disableUser(event.id, token!);
      final profiles = state.profiles;
      profiles[profiles.indexWhere((element) => element.id == profile.id)] =
          profile;
      emit(state.copyWith(
        status: Status.success,
        profiles: profiles,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));
    }

    emit(state.copyWith(status: Status.idle));
  }
}
