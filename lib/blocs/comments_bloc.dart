import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/actions/actions.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/repos/repos.dart';
import 'package:musix_admin/states/states.dart';
import 'package:musix_admin/utils/status.dart';

import '../models/comment.dart';

class CommentsBloc extends Bloc<CommentEvent, CommentState> {
  CommentsBloc({
    required CommentState initialState,
    required this.commentRepo,
    required this.userBloc,
  }) : super(initialState) {
    userBloc.stream.listen((state) {
      if (state.user?.token != null) {
        token = state.user?.token;
      }
    });

    on<GetCommentByPostEvent>(_getCommentByPost);
  }

  final CommentRepo commentRepo;
  final UserBloc userBloc;
  String? token;

  FutureOr<void> _getCommentByPost(
      GetCommentByPostEvent event, Emitter<CommentState> emit) async {
    emit(state.copyWith(
      key: 'Global',
      status: Status.loading,
    ));

    try {
      final result = await commentRepo.getCommentByPost(token!, event.postId);
      List<Comment> comments = [];
      for (final comment in result) {
        final replys = await commentRepo.getReplyComment(token!, comment.id);
        comments.add(comment);
        comments.addAll(replys);
      }

      emit(state.copyWith(
        status: Status.success,
        comments: comments,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));
    }

    emit(state.copyWith(status: Status.idle));
  }

  FutureOr<void> _changeStatusComment(
      ChangeStatusCommentEvent event, Emitter<CommentState> emit) async {
    try {
      final result =
          await commentRepo.changeStatus(token!, event.commentId, event.status);
      emit(state.copyWith(
        status: Status.success,
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
