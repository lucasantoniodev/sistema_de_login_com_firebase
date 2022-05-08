import 'package:flutter/material.dart';
import 'package:login_com_firebase/services/auth_service.dart';
import 'package:login_com_firebase/widgets/animated/custom_animated_text_widget.dart';
import 'package:login_com_firebase/widgets/custom_button_widget.dart';
import 'package:login_com_firebase/widgets/custom_textbutton_widget.dart';
import 'package:login_com_firebase/widgets/custom_textfield_widget.dart';
import 'package:login_com_firebase/widgets/custom_title_widget.dart';
import 'package:provider/provider.dart';

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

  register() async {
    context.read<AuthService>().passwordConfirmed(
        _passwordController.text, _confirmPasswordController.text);
    try {
      await context
          .read<AuthService>()
          .register(_emailController.text, _passwordController.text);
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
                CustomTextFieldWidget(
                  controller: _emailController,
                  label: "Email",
                  icon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFieldWidget(
                  controller: _passwordController,
                  label: "Password",
                  obscure: true,
                  icon: const Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFieldWidget(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  obscure: true,
                  icon: const Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                ),
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
