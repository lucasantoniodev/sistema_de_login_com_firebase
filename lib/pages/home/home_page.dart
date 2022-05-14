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
  // Instância para o FirebaseFirestore
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Usuário instanciado
  final user = FirebaseAuth.instance.currentUser!;

  // document IDs
  List<String> docIDs = [];

  // get docIDs
  Future getDocId() async {
    await db.collection('users').orderBy('age', descending: false).get().then(
      (snapshot) {
        for (var document in snapshot.docs) {
          docIDs.add(document.reference.id);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email!, style: const TextStyle(fontSize: 14)),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: GestureDetector(
              onTap: () => FirebaseAuth.instance.signOut(),
              child: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDocId(),
              builder: (_, __) => ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (_, index) => Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GetUserInfo(documentId: docIDs[index]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
