import 'package:cupon_take/shared/validators/forms_validators.dart';
import 'package:flutter/material.dart';

class UserCredentialsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController? usernameTextController;
  TextEditingController? passwordTextController;

  UserCredentialsForm(
      {super.key, this.usernameTextController, this.passwordTextController});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: usernameTextController,
              decoration: const InputDecoration(
                  labelText: "Nome de usuário", border: OutlineInputBorder()),
              validator: (value) {
                if (!FormsValidators.checkNotEmptyAndLengh(value, 3)) {
                  return "O nome deve ter ao menos 3 caracteres.";
                }

                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordTextController,
              validator: (value) {
                if (!FormsValidators.checkNotEmptyAndLengh(value, 8)) {
                  return "A senha deve ter ao menos 8 caracteres.";
                }

                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Senha", border: OutlineInputBorder()),
            )
          ],
        ));
  }
}
