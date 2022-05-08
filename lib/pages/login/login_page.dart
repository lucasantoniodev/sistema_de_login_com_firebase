import 'package:flutter/material.dart';
import 'package:login_com_firebase/pages/forgot_password_page.dart';
import 'package:login_com_firebase/services/auth_service.dart';
import 'package:login_com_firebase/widgets/animated/custom_animated_text_widget.dart';
import 'package:login_com_firebase/widgets/custom_button_widget.dart';
import 'package:login_com_firebase/widgets/custom_textbutton_widget.dart';
import 'package:login_com_firebase/widgets/custom_textfield_widget.dart';
import 'package:login_com_firebase/widgets/custom_title_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  login() async {
    try {
      await context
          .read<AuthService>()
          .singIn(_emailController.text, _passwordController.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
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
                    controller: _emailController,
                    label: 'Email',
                    icon: const Icon(Icons.email, color: Colors.black,),
                  ),

                  const SizedBox(height: 10),

                  // INPUT Password
                  CustomTextFieldWidget(
                    controller: _passwordController,
                    label: 'Password',
                    obscure: true,
                    icon: const Icon(Icons.password,color: Colors.black),
                  ),

                  const SizedBox(height: 10),

                  CustomTextButtonWidget(
                      text: 'Forgot Password?',
                      method: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgotPasswordPage();
                              },
                            ),
                          )),

                  const SizedBox(height: 10),

                  CustomButtonWidget(method: login, text: "Sing In"),

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
