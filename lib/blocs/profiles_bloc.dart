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
  }

  final UserBloc userBloc;
  final ProfileRepo profileRepo;
  String? token;

  FutureOr<void> _loadProfiles(
      LoadProfilesEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
    ));
    print(token);
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
}
