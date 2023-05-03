import 'package:flutter/material.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:get/get.dart';

class CreateNewMealDialog extends StatefulWidget {
  CreateNewMealDialog({
    super.key,
    required this.onCreate
  });

  @override
  State<CreateNewMealDialog> createState() => _CreateNewMealDialog();

  final UserService userService = Get.find<UserService>();
  final void Function() onCreate;
}

class _CreateNewMealDialog extends State<CreateNewMealDialog> {

  final _formKey = GlobalKey<FormState>();

  String? name;
  bool showProgress = false;

  @override
  Widget build(BuildContext build) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0, bottom: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  RegExp regexp = RegExp(r'^[A-z0-9() ]{4,50}$');

                  if (value == null || value.isEmpty) {
                    return "Please provide a name.";
                  }

                  if (value.length < 4) {
                    return "Provide a name at least 4 characters long!";
                  }

                  if (value.length > 50) {
                    return "Provide a name shorter than 50 characters!";
                  }

                  if (!regexp.hasMatch(value)) {
                    return "Special characters are not allowed!";
                  }

                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showProgress
                      ? const CircularProgressIndicator()
                      : Expanded(
                          child: FilledButton(
                              onPressed: () => _onAdd(context),
                              child: const Text("Create new meal")),
                        ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }

  Future<void> _onAdd(BuildContext context) async {
    if (_formKey.currentState!.validate()) {

      ThemeData theme = Theme.of(context);

      setState(() {
        showProgress = true;
      });

      try {
        await widget.userService.createNewUsersMeal(name!);

        if (!context.mounted) return;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text("Your meal has been created!"),
            backgroundColor: Colors.green,
          ));

        widget.onCreate();
        Navigator.pop(context);

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
