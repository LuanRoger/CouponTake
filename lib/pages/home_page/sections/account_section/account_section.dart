import 'package:cupon_take/pages/home_page/sections/account_section/widgets/user_credentials_form.dart';
import 'package:flutter/material.dart';

class AccountSection extends StatefulWidget {
  const AccountSection({super.key});

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  bool enter = false;
  late UserCredentialsForm credentialsForm;

  @override
  void initState() {
    super.initState();

    credentialsForm = UserCredentialsForm();
  }

  Widget _buildCredentialsForm() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
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
                  onPressed: () {
                    if (credentialsForm.formKey.currentState!.validate()) {
                      setState(() {
                        enter = true;
                      });
                    }
                  }),
              ElevatedButton(
                  child: Text("Cadastrar"),
                  onPressed: () {
                    if (credentialsForm.formKey.currentState!.validate()) {
                      setState(() {
                        enter = true;
                      });
                    }
                  })
            ],
          )
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Center(
      child: Column(children: [
        Text("lroger"),
        ElevatedButton.icon(
            label: Text("Sair"),
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () {
              setState(() {
                enter = false;
              });
            }),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Conta")),
        body: enter ? _buildUserInfo() : _buildCredentialsForm());
  }
}
