import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/states/states.dart';

import '../utils/status.dart';

class CommentDataTable extends StatelessWidget {
  const CommentDataTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentState>(builder: (context, state) {
      if (state.status == Status.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == Status.idle && state.comments.isEmpty) {
        return const Text(
          'There is no comment in this post.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        );
      }
      return DataTable2(
          dividerThickness: 4,
          columnSpacing: 0,
          horizontalMargin: 12,
          bottomMargin: 20,
          minWidth: 1600,
          fixedTopRows: 0,
          fixedLeftColumns: 0,
          lmRatio: 2.4,
          columns: const [
            DataColumn2(
              label: Text(
                'No. ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              fixedWidth: 36,
            ),
            DataColumn2(
              label: Text(
                'Comment Id',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                'Content',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                'Owner Id',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                'Owner Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(
                'Like',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              fixedWidth: 48,
            ),
            DataColumn2(
              label: Text(
                'Date Created',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(
                'Last Modified',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(
                'Reply Comments',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                'Status',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              size: ColumnSize.S,
            ),
          ],
          rows: List<DataRow>.generate(state.comments.length, (index) {
            final comment = state.comments[index];
            return DataRow(cells: [
              DataCell(
                Text('${index + 1}'),
              ),
              DataCell(
                Text(comment.id),
              ),
              DataCell(
                Text(comment.content),
              ),
              DataCell(
                Text(comment.ownerId),
              ),
              DataCell(
                Text(comment.ownerUsername),
              ),
              DataCell(
                Text('${comment.likeBy.length}'),
              ),
              DataCell(
                Text(DateFormat('dd/MM/yyyy').format(
                    DateTime.fromMillisecondsSinceEpoch(comment.dateCreated))),
              ),
              DataCell(
                Text(DateFormat('dd/MM/yyyy').format(
                    DateTime.fromMillisecondsSinceEpoch(comment.lastModified))),
              ),
              DataCell(
                Text(comment.replyComment ?? ""),
              ),
              DataCell(
                Text(comment.status),
              ),
            ]);
          }));
    });
  }
}
