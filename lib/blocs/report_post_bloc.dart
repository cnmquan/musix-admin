import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/repos/report_post_repo.dart';

import '../actions/report_post_event.dart';
import '../states/report_post_state.dart';
import '../utils/status.dart';

class ReportPostBloc extends Bloc<ReportPostEvent, ReportPostState> {
  ReportPostBloc({
    required ReportPostState initialState,
    required this.userBloc,
    required this.reportPostRepo,
  }) : super(initialState) {
    userBloc.stream.listen((state) {
      if (state.user?.token != null) {
        token = state.user?.token;
      }
    });
    on<GetReportsPostEvent>(_getReportPosts);
    on<GetReportsByPostIdEvent>(_getReportsByPostId);
  }
  final UserBloc userBloc;
  final ReportPostRepo reportPostRepo;
  String? token;
  FutureOr<void> _getReportPosts(
      ReportPostEvent event, Emitter<ReportPostState> emit) async {
    emit(state.copyWith(
      key: "Global",
      status: Status.loading,
    ));
    try {
      final reportPosts = await reportPostRepo.getReportPosts(token!);
      emit(state.copyWith(status: Status.success, reportPosts: reportPosts));
    } catch (e) {
      print("error occured $e");
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));
    }
    emit(state.copyWith(status: Status.idle));
  }

  FutureOr<void> _getReportsByPostId(
      GetReportsByPostIdEvent event, Emitter<ReportPostState> emit) async {
    emit(state.copyWith(
      key: "Global",
      status: Status.loading,
    ));
    try {
      final reportPosts =
          await reportPostRepo.getReportsByPostId(token!, event.postId);
      print("reportPosts is $reportPosts");

      emit(state.copyWith(status: Status.success, reportPosts: reportPosts));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        error: e.toString(),
      ));
    }
    emit(state.copyWith(status: Status.idle));
  }
}
