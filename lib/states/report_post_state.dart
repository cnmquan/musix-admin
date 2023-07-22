import 'package:equatable/equatable.dart';
import 'package:musix_admin/models/report_post.dart';
import 'package:musix_admin/utils/status.dart';

class ReportPostState extends Equatable {
  final String key;
  final Status status;
  final List<ReportPost> reportPosts;
  final String? error;

  const ReportPostState(
      {required this.key,
      required this.status,
      required this.reportPosts,
      this.error});
  ReportPostState copyWith({
    String? key,
    Status? status,
    List<ReportPost>? reportPosts,
    String? error,
  }) =>
      ReportPostState(
          key: key ?? this.key,
          status: status ?? this.status,
          reportPosts: reportPosts ?? this.reportPosts,
          error: error ?? this.error);
  @override
  List<Object?> get props => [
        key,
        status,
        reportPosts,
        error,
      ];
}
