import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_com_firebase/widgets/animated/custom_animated_text_widget.dart';
import 'package:login_com_firebase/widgets/custom_button_widget.dart';
import 'package:login_com_firebase/widgets/custom_textbutton_widget.dart';
import 'package:login_com_firebase/widgets/custom_textfield_widget.dart';
import 'package:login_com_firebase/widgets/custom_title_widget.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future register() async {
    if (_passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } catch (e) {
        return ScaffoldMessenger(
            child: SnackBar(
          content: Text(e.toString()),
        ));
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.purple,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone_android, size: 200),
                const SizedBox(height: 75),
                const CustomTitleWidget(text: 'Register now'),
                const SizedBox(height: 10),
                const CustomAnimatedText(
                    text: 'Register below with your details!'),
                const SizedBox(height: 50),
                CustomTextFieldWidget(controller: _emailController, label: "Email"),
                const SizedBox(height: 10),
                CustomTextFieldWidget(controller: _passwordController, label: "Password"),
                const SizedBox(height: 10),
                CustomTextFieldWidget(controller: _confirmPasswordController, label: "Confirm Password"),
                const SizedBox(height: 10),
                CustomButtonWidget(method: register, text: 'Register'),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'I am a member',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    CustomTextButtonWidget(
                        method: widget.showLoginPage, text: 'Login now')
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
