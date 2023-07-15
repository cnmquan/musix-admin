import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/actions/actions.dart';
import 'package:musix_admin/repos/repos.dart';
import 'package:musix_admin/states/states.dart';

import '../utils/utils.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required UserState initialState,
    required this.userRepo,
  }) : super(initialState) {
    on<SignInEvent>(_signIn);
    on<LogoutEvent>(_logout);
  }

  final UserRepo userRepo;

  FutureOr<void> _signIn(SignInEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: Status.loading));

    // Call API
    try {
      final user = await userRepo.signIn(
          username: event.username, password: event.password);
      emit(state.copyWith(
        status: Status.success,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));
    }
    emit(state.copyWith(status: Status.idle));
  }

  FutureOr<void> _logout(LogoutEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await userRepo.logout(state.user!.token);
      emit(state.copyWith(status: Status.success));

      emit(const UserState(status: Status.idle));
      return;
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));

      emit(state.copyWith(status: Status.idle));
    }
  }
}
