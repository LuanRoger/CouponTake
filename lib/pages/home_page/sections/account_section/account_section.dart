// ignore_for_file: use_build_context_synchronously

import 'package:coupon_take/models/enums/http_codes.dart';
import 'package:coupon_take/models/http_response.dart';
import 'package:coupon_take/models/user_info_http_request.dart';
import 'package:coupon_take/pages/home_page/sections/account_section/widgets/user_credentials_form.dart';
import 'package:coupon_take/providers/providers.dart';
import 'package:coupon_take/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountSection extends HookConsumerWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoProvider = ref.watch(fetchUserInfoProvider);

    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.appBarAccountTitle)),
        body: userInfoProvider.maybeWhen(
            data: (info) => _UserInfoViwer(info.username),
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const _UserCredentialsForm()));
  }
}

class _UserCredentialsForm extends HookConsumerWidget {
  const _UserCredentialsForm();

  Future<bool> _login(
      WidgetRef ref, UserInfoHttpRequest userInfoRequest) async {
    AuthServices authServices = AuthServices();
    HttpResponse response = await authServices.login(userInfoRequest);

    if (response.statusCode != HttpCodes.SUCCESS.code) {
      return false;
    }

    ref.read(preferencesProvider).coupontakeAuthKey = response.body;
    return true;
  }

  Future<bool> _register(
      WidgetRef ref, UserInfoHttpRequest userInfoRequest) async {
    AuthServices authServices = AuthServices();
    HttpResponse response = await authServices.register(userInfoRequest);

    if (response.statusCode != HttpCodes.SUCCESS.code) {
      return false;
    }

    ref.read(preferencesProvider).coupontakeAuthKey = response.body;
    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoadingState = useState(false);
    final usernameTextControllerState = useTextEditingController();
    final passwordTextControllerState = useTextEditingController();
    final UserCredentialsForm credentialsForm =
        useMemoized(() => UserCredentialsForm(
              usernameTextController: usernameTextControllerState,
              passwordTextController: passwordTextControllerState,
            ));

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: isLoadingState.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                credentialsForm,
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        child: Text(AppLocalizations.of(context)!.buttonLogin),
                        onPressed: () async {
                          isLoadingState.value = true;
                          if (credentialsForm.formKey.currentState!
                              .validate()) {
                            bool success = await _login(
                                ref,
                                UserInfoHttpRequest(
                                    usernameTextControllerState.text,
                                    passwordTextControllerState.text));
                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .snackBarIncorrectCredentials)));
                            }
                          }
                          isLoadingState.value = false;
                        }),
                    ElevatedButton(
                        child: Text(AppLocalizations.of(context)!.buttonSignin),
                        onPressed: () async {
                          isLoadingState.value = true;
                          if (credentialsForm.formKey.currentState!
                              .validate()) {
                            bool success = await _register(
                                ref,
                                UserInfoHttpRequest(
                                    usernameTextControllerState.text,
                                    passwordTextControllerState.text));
                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .snackBarIncorrectCredentials)));
                            }
                          }
                          isLoadingState.value = false;
                        })
                  ],
                )
              ],
            ),
    );
  }
}

class _UserInfoViwer extends HookConsumerWidget {
  final String username;

  const _UserInfoViwer(this.username);

  void _logout(WidgetRef ref) {
    ref.read(userAuthProvider.notifier).logout();
    ref.read(preferencesProvider).coupontakeAuthKey = null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(children: [
        Text(username),
        ElevatedButton.icon(
            label: const Text("Sair"),
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () => _logout(ref)),
      ]),
    );
  }
}
