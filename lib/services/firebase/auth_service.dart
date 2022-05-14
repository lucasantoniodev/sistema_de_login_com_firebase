import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  bool _passwordConfirmed = false;
  void passwordConfirmed(String password, String confirmPassword) {
    if (password.trim() == confirmPassword.trim()) {
      _passwordConfirmed = true;
    }
  }

  _getUser() {
    usuario = _auth.currentUser;

    notifyListeners();
  }

  Future register(String email, String password) async {
    if (_passwordConfirmed) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

        _getUser();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          throw AuthException('A senha é muito fraca!');
        } else if (e.code == 'email-already-in-use') {
          throw AuthException('Este email já está cadastrado');
        }
      }
    } else {
      throw AuthException('As senhas não são iguais');
    }
  }

  Future singIn(String email, String password) async {
    isLoading = true;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      _getUser();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
