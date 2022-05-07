import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_com_firebase/pages/forgot_password_page.dart';
import 'package:login_com_firebase/widgets/animated/custom_animated_text_widget.dart';
import 'package:login_com_firebase/widgets/custom_button_widget.dart';
import 'package:login_com_firebase/widgets/custom_textbutton_widget.dart';
import 'package:login_com_firebase/widgets/custom_textfield_widget.dart';
import 'package:login_com_firebase/widgets/custom_title_widget.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future singIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
        ),
      );
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
    navigation() {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ForgotPasswordPage();
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.adb_sharp, size: 200),

                  const SizedBox(height: 75),

                  const CustomTitleWidget(text: 'Hello Again'),

                  const SizedBox(height: 10),

                  const CustomAnimatedText(
                      text: 'Welcome back, you\'ve been missed!'),
                  const SizedBox(height: 50),

                  // INPUT Email
                  CustomTextFieldWidget(
                      controller: _emailController, label: 'Email'),

                  const SizedBox(height: 10),

                  // INPUT Password
                  CustomTextFieldWidget(
                    controller: _passwordController,
                    label: 'Password',
                    obscure: true,
                  ),

                  const SizedBox(height: 10),

                  CustomTextButtonWidget(
                      text: 'Forgot Password?', method: navigation),

                  const SizedBox(height: 10),

                  CustomButtonWidget(method: singIn, text: "Sing In"),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      CustomTextButtonWidget(
                          method: widget.showRegisterPage, text: "Register Now")
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
