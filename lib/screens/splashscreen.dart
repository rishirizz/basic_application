// ignore_for_file: use_build_context_synchronously, constant_identifier_names
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? loginCheck = false;
  @override
  void initState() {
    super.initState();
    loginCheck = prefs!.getBool('login');
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: FlutterLogo(
          size: 48,
        ),
      ),
    );
  }

  navigate() async {
    if (loginCheck == true) {
      Future.delayed(const Duration(seconds: 2),
          () => Navigator.of(context).pushReplacementNamed('/home'));
    } else {
      Future.delayed(const Duration(seconds: 2),
          () => Navigator.of(context).pushReplacementNamed('/login'));
    }
  }
}
