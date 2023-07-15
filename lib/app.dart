import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/di.dart';
import 'package:musix_admin/repos/repos.dart';
import 'package:musix_admin/states/states.dart';
import 'package:musix_admin/utils/utils.dart';

import 'views/views.dart';

class MusicAdminApp extends StatelessWidget {
  const MusicAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<UserBloc>(
        create: (context) => UserBloc(
          initialState: const UserState(
            status: Status.idle,
          ),
          userRepo: getIt.get<UserRepo>(),
        ),
      ),
    ], child: const MusicAdminAppView());
  }
}

class MusicAdminAppView extends StatelessWidget {
  const MusicAdminAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Admin',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}
