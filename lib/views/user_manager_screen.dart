import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/actions/actions.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/states/states.dart';
import 'package:musix_admin/views/set_admin_screen.dart';
import 'package:musix_admin/widget/appbar.dart';

import '../models/models.dart';

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
        listenWhen: (prev, curr) => curr.key == 'Global',
        listener: (childContext, state) {
          // if (state.status == Status.loading) {
          //   buildShowDialog(context);
          // } else if (state.status == Status.success) {
          //   Navigator.of(childContext).maybePop();
          // } else if (state.status == Status.error) {
          //   Navigator.of(childContext).maybePop();
          // }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: FilledButton.tonalIcon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SetAdminScreen()));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create Admin Account')),
              ),
              Expanded(
                child: BlocBuilder<ProfilesBloc, ProfileState>(
                  builder: (context, state) {
                    return DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 800,
                      columns: const [
                        DataColumn2(
                          label: Text('No.'),
                          fixedWidth: 36,
                        ),
                        DataColumn2(
                          label: Text('Id'),
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
                        DataColumn2(
                          label: SizedBox.shrink(),
                          fixedWidth: 32,
                        ),
                      ],
                      rows: List<DataRow>.generate(state.profiles.length,
                          (index) {
                        final profile = state.profiles[index];
                        final isUser =
                            context.read<UserBloc>().state.user?.id ==
                                profile.id;
                        return DataRow(
                          cells: [
                            DataCell(Text('$index')),
                            DataCell(Text(profile.id)),
                            DataCell(Text(profile.username)),
                            DataCell(Text(profile.email ?? "")),
                            DataCell(Text(profile.fullName ?? "")),
                            DataCell(Text(profile.role)),
                            DataCell(
                              Text(profile.enable ? 'In Active' : 'No Active'),
                            ),
                            DataCell(
                                isUser
                                    ? const SizedBox.shrink()
                                    : const Icon(Icons.edit),
                                onTap: isUser
                                    ? null
                                    : () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return BlockAccount(
                                                profile: profile,
                                              );
                                            });
                                      }),
                          ],
                        );
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class BlockAccount extends StatelessWidget {
  final Profile profile;
  const BlockAccount({
    required this.profile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Warning',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.lightBlue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Do you want to ${profile.enable ? "block" : "re-active"} account ${profile.username}?',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            OutlinedButton(
                onPressed: () {
                  context
                      .read<ProfilesBloc>()
                      .add(DisableProfileEvent(profile.id));
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                  backgroundColor: MaterialStateProperty.all(Colors.white70),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                )),
            const SizedBox(
              height: 12,
            ),
            OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                  backgroundColor: MaterialStateProperty.all(Colors.white70),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
