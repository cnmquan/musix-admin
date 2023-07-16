import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musix_admin/actions/actions.dart';
import 'package:musix_admin/blocs/profiles_bloc.dart';
import 'package:musix_admin/states/profile_state.dart';
import 'package:musix_admin/widget/appbar.dart';

import '../utils/utils.dart';

class SetAdminScreen extends StatefulWidget {
  const SetAdminScreen({Key? key}) : super(key: key);

  @override
  State<SetAdminScreen> createState() => _SetAdminScreenState();
}

class _SetAdminScreenState extends State<SetAdminScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  bool obscureText = true;
  String? error;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Set Admin'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 12,
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
                    controller: nameController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Name',
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
                  BlocListener<ProfilesBloc, ProfileState>(
                    listenWhen: (prev, curr) => curr.key == 'SetAdmin',
                    listener: (childContext, state) {
                      if (state.status == Status.loading) {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black12,
                          barrierDismissible: false,
                          useRootNavigator: false,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SpinKitChasingDots(
                                      color: Colors.white70,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state.status == Status.success) {
                        Navigator.of(context).pop();
                        Future.delayed(const Duration(milliseconds: 200),
                            () => Navigator.of(context).maybePop());
                      } else if (state.status == Status.error) {
                        Future.delayed(const Duration(milliseconds: 100),
                                () => Navigator.of(context).pop())
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

                      context.read<ProfilesBloc>().add(SetProfileAdminEvent(
                            username: usernameController.text,
                            password: passwordController.text,
                            name: nameController.text,
                          ));
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
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white54),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
                    ),
                    child: const Text(
                      'Set Admin Account',
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
      ),
    );
  }
}
