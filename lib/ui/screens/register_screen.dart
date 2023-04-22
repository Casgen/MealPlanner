import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/side_menu.dart';
import 'package:umte_project/ui/screens/login_screen.dart';
import 'package:umte_project/utils/validation_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final UserService userService = Get.find<UserService>();

  String username = '';
  String password = '';
  String passwordAgain = '';

  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return LayoutBuilder(builder: (builder, constraints) {
      return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
            backgroundColor: theme.primaryColor,
            titleTextStyle: theme.textTheme.headlineSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
            title: const Text("Home")),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                        ),
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                        validator: ValidationUtils.validateUsername,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: ValidationUtils.validatePassword,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Confirm password",
                        ),
                        onChanged: (value) {
                          setState(() {
                            passwordAgain = value;
                          });
                        },
                        validator: (value) {
                          String? error = ValidationUtils.validatePassword(value);

                          if (error != null) {
                            return error;
                          }

                          if (password != value) {
                            return "Passwords do not match!";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          showProgress
                          ? const CircularProgressIndicator()
                          : Expanded(
                            child: FilledButton(
                                onPressed: () => signUp(context),
                                child: const Text("Sign up")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          showProgress = true;
        });

        await userService.registerUser(username, password);

        // Checks whether the building of the widget is done. otherwise wait
        // for it to mount.
        if (!context.mounted) return;

        Navigator.pop(context, "Registration successful!");


      } catch (err) {
        print("RuntimeError: $err");
        setState(() {
          showProgress = false;
        });
      }

    }
  }
}
