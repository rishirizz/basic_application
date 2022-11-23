// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks
import 'package:flutter/material.dart';

import '../api_model/api_model.dart';
import '../constants/constants.dart';
import '../service/service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginRequestModel loginRequestModel = LoginRequestModel();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPasswordShow = false;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Center(
          child: (isApiCallProcess == true)
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextFormField(
                              autofillHints: const [AutofillHints.email],
                              controller: emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 11, 12, 12),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 18, 18, 18),
                                      width: 1.0),
                                ),
                                hintText: 'Email ',
                              ),
                              validator: (input) => input!.isValidEmail()
                                  ? null
                                  : "Enter a valid email",
                              onSaved: (val) {
                                loginRequestModel.email = val;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: !isPasswordShow,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: (isPasswordShow == true)
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordShow = !isPasswordShow;
                                    });
                                  },
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 11, 12, 12),
                                      width: 1.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 11, 11, 11),
                                      width: 1.0),
                                ),
                                hintText: 'Password ',
                              ),
                              validator: (input) {
                                if (input != null) {
                                  if (input.length < 6) {
                                    return 'Password is too short';
                                  }
                                }
                                return null;
                              },
                              onSaved: (val) {
                                loginRequestModel.password = val;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              submitForm();
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  bool submitForm() {
    final form = formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        debugPrint('Form is saved');
        sureConsent();
        return true;
      }
    }
    debugPrint('Form is null');
    return false;
  }

  sureConsent() {
    setState(() {
      isApiCallProcess = true;
    });
    login(loginRequestModel).then((response) async {
      setState(() {
        isApiCallProcess = false;
      });
      if (response == null) {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text('invalid Username.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text(
              'Logged in successfully',
            ),
          ),
        );
        prefs!.setBool('login', true);
        Navigator.of(context).pushReplacementNamed('/splash');
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
