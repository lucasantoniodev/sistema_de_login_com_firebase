import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_com_firebase/components/get_user_info_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // document IDs
  List<String> docIDs = [];

  // get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then((snapshot) {
      for (var document in snapshot.docs) {
        docIDs.add(document.reference.id);
      }

      // snapshot.docs.forEach((document) {
      //   print(document.reference);
      //   docIDs.add(document.reference.id);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email!, style: const TextStyle(fontSize: 14)),
        actions: [
          GestureDetector(
              onTap: () => FirebaseAuth.instance.signOut(),
              child: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (_, __) => ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: GetUserInfo(documentId: docIDs[index]),
                      tileColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
