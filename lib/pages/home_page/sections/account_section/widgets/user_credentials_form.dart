import 'package:coupon_take/shared/validators/forms_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.textFieldUsername,
                  border: const OutlineInputBorder()),
              validator: (value) {
                if (!FormsValidators.checkNotEmptyAndLengh(value, 3)) {
                  return AppLocalizations.of(context)!
                      .textFieldValidationErrorUsername;
                }

                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordTextController,
              validator: (value) {
                if (!FormsValidators.checkNotEmptyAndLengh(value, 8)) {
                  return AppLocalizations.of(context)!
                      .textFieldValidationErrorPassword;
                }

                return null;
              },
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.textFieldPassword,
                  border: const OutlineInputBorder()),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            )
          ],
        ));
  }
}
