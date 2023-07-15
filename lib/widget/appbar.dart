import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/actions/actions.dart';
import 'package:musix_admin/utils/utils.dart';

import '../blocs/blocs.dart';
import '../states/states.dart';
import '../views/views.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 28,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: const SizedBox.shrink(),
        ),
        IconButton(
          onPressed: () {
            context.read<UserBloc>().add(const LogoutEvent());
          },
          icon: const Icon(
            Icons.exit_to_app_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
