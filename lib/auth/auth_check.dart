import 'package:flutter/material.dart';
import 'package:login_com_firebase/auth/auth_page.dart';
import 'package:login_com_firebase/pages/home/home_page.dart';
import 'package:login_com_firebase/services/firebase/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    loading() {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const AuthPage();
    } else {
      
      return const HomePage();
    }
  }
}
