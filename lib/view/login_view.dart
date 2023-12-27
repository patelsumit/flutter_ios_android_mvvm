import 'package:flutter/material.dart';
import 'package:flutter_ios_android_mvvm/res/components/round_button.dart';
import 'package:flutter_ios_android_mvvm/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../res/color.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: 'enter email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.alternate_email),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecurePassword.value,
                    obscuringCharacter: '*',
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'enter password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_clock_rounded),
                      suffixIcon: InkWell(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: Icon(_obsecurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility)),
                    ),
                  );
                }),
            SizedBox(
              height: height * .085,
            ),
            RoundButton(
              title: 'Login',
              loading: authViewModel.loading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarMessage('Please enter an email', context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarMessage('Please enter password', context);
                } else if (_passwordController.text.length < 6) {
                  Utils.flushBarMessage(
                      'Please enter 6 digit password', context);
                } else {
                  Map data = {
                    'email': _emailController.text.toString(),
                    'password': _passwordController.text.toString()
                  };
                  authViewModel.loginApi(data, context);
                }
              },
            ),
            SizedBox(
              height: height * .02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.signUp);
                },
                child: Text("Don't have an account? Sign Up"))
          ],
        ),
      ),
    );
  }
}
