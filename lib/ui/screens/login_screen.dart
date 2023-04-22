import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/side_menu.dart';
import 'package:umte_project/ui/screens/home_screen.dart';
import 'package:umte_project/ui/screens/register_screen.dart';
import 'package:umte_project/utils/validation_utils.dart';

import '../../data/enums/response_enum.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final UserService userService = Get.find<UserService>();

  String username = '';
  String password = '';

  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle signUpStyle = theme.textTheme.labelLarge!
        .copyWith(decoration: TextDecoration.underline);

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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));

                              if (!mounted) return;

                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                    SnackBar(content: Text("$result")));
                            },
                            child: Text(
                              "Sign up!",
                              style: signUpStyle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          showProgress
                              ? const CircularProgressIndicator()
                              : Expanded(
                                  child: FilledButton(
                                      onPressed: () => onLogin(context),
                                      child: const Text("Login")),
                                ),
                        ],
                      )
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

  Future<void> onLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      ThemeData theme = Theme.of(context);

      setState(() {
        showProgress = true;
      });

      try {
        ResponseEnum res = await userService.loginUser(username, password);

        if (res != ResponseEnum.success) {
          if (!context.mounted) return;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(res.getMessage()),
              backgroundColor: theme.colorScheme.error,
            ));

          setState(() {
            showProgress = false;
          });
        } else {
          // Checks whether the building of the widget is done. otherwise wait
          // for it to mount.
          if (!context.mounted) return;

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      } catch (err) {
        print("RuntimeError: $err");
        setState(() {
          showProgress = false;
        });

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: const Text("There was an error logging in!"),
            backgroundColor: theme.colorScheme.error,
          ));
      }
    }
  }
}
