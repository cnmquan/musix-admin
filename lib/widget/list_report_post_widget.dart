import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:musix_admin/models/report_post.dart';

class ListReportPostWidget extends StatelessWidget {
  const ListReportPostWidget({
    super.key,
    required this.reportPosts,
  });
  final List<ReportPost> reportPosts;
  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      columns: const [
        DataColumn(
          label: Text("No"),
        ),
        DataColumn(
          label: Text("ID"),
        ),
        DataColumn(
          label: Text("Report by"),
        ),
        DataColumn(
          label: Text("Reason"),
        ),
      ],
      rows: List.generate(reportPosts.length, (index) {
        final reportPost = reportPosts[index];
        return DataRow(cells: [
          DataCell(Text("$index")),
          DataCell(Text(reportPost.id)),
          DataCell(Text(reportPost.user.username)),
          DataCell(Text(reportPost.reason)),
        ]);
      }),
    );
  }
}
