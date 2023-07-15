import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/states/states.dart';
import 'package:musix_admin/utils/utils.dart';
import 'package:musix_admin/widget/appbar.dart';

class UserManagerScreen extends StatelessWidget {
  const UserManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CustomAppbar(
        title: 'User Manager',
      ),
      body: BlocListener<ProfilesBloc, ProfileState>(
        listener: (childContext, state) {
          if (state.status == Status.loading) {
            buildShowDialog(childContext);
          } else if (state.status == Status.success) {
            // Navigator.of(childContext).maybePop();
          } else if (state.status == Status.error) {
            // Navigator.of(childContext).maybePop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ProfilesBloc, ProfileState>(
            builder: (context, state) {
              return DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 800,
                columns: const [
                  DataColumn2(
                    label: Text('No.'),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text('Username'),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Text('Email'),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text('Name'),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Text('Role'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Enable'),
                    size: ColumnSize.S,
                  ),
                ],
                rows: List<DataRow>.generate(state.profiles.length, (index) {
                  final profile = state.profiles[index];
                  return DataRow(cells: [
                    DataCell(Text(profile.id)),
                    DataCell(Text(profile.username)),
                    DataCell(Text(profile.email ?? "Empty")),
                    DataCell(Text(profile.fullName ?? "Empty")),
                    DataCell(Text(profile.role)),
                    DataCell(Text(profile.enable ? 'In Active' : 'No Active')),
                  ]);
                }),
              );
            },
          ),
        ),
      ),
    ));
  }
}
