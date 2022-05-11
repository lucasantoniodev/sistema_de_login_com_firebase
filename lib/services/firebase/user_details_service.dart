import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsService {
  static final UserDetailsService instance = UserDetailsService._();
  UserDetailsService._();

  Future addUserDetails(
      String firstName, String lastName, String email, String age) async {
    await FirebaseFirestore.instance.collection('users').add({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "age": int.parse(age),
    });
    
  }


}
