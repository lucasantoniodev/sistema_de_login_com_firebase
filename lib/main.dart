import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_com_firebase/auth/auth_check.dart';
import 'package:login_com_firebase/firebase_options.dart';
import 'package:login_com_firebase/services/firebase/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthService()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        backgroundColor: Colors.grey,
        primarySwatch: Colors.purple,
      ),
      home: const AuthCheck(),
    );
  }
}
