import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/states/states.dart';
import 'package:musix_admin/utils/utils.dart';

import '../actions/actions.dart';
import 'views.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;
  String? error;
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'MUSIX Admin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    wordSpacing: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                TextField(
                  controller: usernameController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: obscureText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                      suffixIconColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.black,
                        ),
                      )),
                ),
                if (error != null) ...[
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    error!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ] else ...[
                  const SizedBox(
                    height: 48,
                  ),
                ],
                BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state.status == Status.loading) {
                      buildShowDialog(context);
                    } else if (state.status == Status.success) {
                      Future.delayed(const Duration(milliseconds: 100),
                              () => Navigator.of(context).maybePop())
                          .whenComplete(() => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      const DashboardScreen())));
                    } else if (state.status == Status.error) {
                      Future.delayed(const Duration(milliseconds: 100),
                              () => Navigator.of(context).maybePop())
                          .whenComplete(() => setState(() {
                                error = state.error ?? 'Login error!';
                              }));
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      setState(() {
                        error = 'Username / Password is not empty';
                      });
                      return;
                    } else {
                      setState(() {
                        error = null;
                      });
                    }

                    context.read<UserBloc>().add(SignInEvent(
                        username: usernameController.text,
                        password: passwordController.text));
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.white54),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(12)),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
