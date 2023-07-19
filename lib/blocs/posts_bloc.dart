import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/blocs/user_bloc.dart';
import 'package:musix_admin/repos/repos.dart';

import '../actions/actions.dart';
import '../states/states.dart';
import '../utils/utils.dart';

class PostsBloc extends Bloc<PostEvent, PostState> {
  PostsBloc({
    required PostState initialState,
    required this.userBloc,
    required this.postRepo,
  }) : super(initialState) {
    userBloc.stream.listen((state) {
      if (state.user?.token != null) {
        token = state.user?.token;
      }
    });

    on<GetPostsEvent>(_getPosts);
    on<ChangingStatusPostEvent>(_changeStatusPost);
  }

  final PostRepo postRepo;
  final UserBloc userBloc;
  String? token;

  FutureOr<void> _getPosts(GetPostsEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(
      key: 'Global',
      status: Status.loading,
    ));
    try {
      final posts = await postRepo.getPosts(token!);
      emit(state.copyWith(
        status: Status.success,
        posts: posts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));
    }

    emit(state.copyWith(status: Status.idle));
  }

  FutureOr<void> _changeStatusPost(
      ChangingStatusPostEvent event, Emitter<PostState> emit) async {}
}
