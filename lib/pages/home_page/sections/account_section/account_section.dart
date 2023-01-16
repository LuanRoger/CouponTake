import 'package:cupon_take/models/enums/http_codes.dart';
import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/user_info_http_request.dart';
import 'package:cupon_take/pages/home_page/sections/account_section/widgets/user_credentials_form.dart';
import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountSection extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoProvider = ref.watch(fetchUserInfoProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Conta")),
        body: userInfoProvider.maybeWhen(
            data: (info) => _UserInfoViwer(info.username),
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const _UserCredentialsForm()));
  }
}

class _UserCredentialsForm extends HookConsumerWidget {
  const _UserCredentialsForm({super.key});

  Future<bool> _login(
      WidgetRef ref, UserInfoHttpRequest userInfoRequest) async {
    AuthServices authServices = AuthServices();
    HttpResponse response = await authServices.login(userInfoRequest);

    if (response.statusCode != HttpCodes.SUCCESS.code) {
      return false;
    }

    ref.read(preferencesProvider).cupontakeAuthKey = response.body;
    return true;
  }

  Future<bool> _register(
      WidgetRef ref, UserInfoHttpRequest userInfoRequest) async {
    AuthServices authServices = AuthServices();
    HttpResponse response = await authServices.register(userInfoRequest);

    if (response.statusCode != HttpCodes.SUCCESS.code) {
      return false;
    }

    ref.read(preferencesProvider).cupontakeAuthKey = response.body;
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
                        child: Text("Entrar"),
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
                                  const SnackBar(
                                      content: Text("Credenciais incorretas")));
                            }
                          }
                          isLoadingState.value = false;
                        }),
                    ElevatedButton(
                        child: Text("Cadastrar"),
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
                                  const SnackBar(
                                      content: Text("Credenciais incorretas")));
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

  const _UserInfoViwer(this.username, {super.key});

  void _logout(WidgetRef ref) {
    ref.read(userAuthProvider.notifier).logout();
    ref.read(preferencesProvider).cupontakeAuthKey = null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(children: [
        Text(username),
        ElevatedButton.icon(
            label: Text("Sair"),
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () => _logout(ref)),
      ]),
    );
  }
}
