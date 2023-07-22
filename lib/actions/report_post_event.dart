abstract class ReportPostEvent {}

class GetReportsPostEvent implements ReportPostEvent {}

class GetReportsByPostIdEvent implements ReportPostEvent {
  final String postId;

  GetReportsByPostIdEvent(this.postId);
}
