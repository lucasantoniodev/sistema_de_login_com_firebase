import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserInfo extends StatelessWidget {
  final String documentId;

  const GetUserInfo({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference users = db.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Variável que captura um Object e ele precisa ser transformado em String ou Map caso os dados seja o json.
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Text(
                '${data['firstName']} ${data['lastName']} ${data['age']} years old');
          }
          return const Text('Loading...');
        });
  }
}

/** WIDGET PARA IMPORTAÇÃO DOS DADOS
 * 
 * O Widget começa recebendo um parâmetro ("documentId") que contem o ID de referência do banco de dados de cada usuário.
 * 
 * Após o método build foi criado duas variáveis, 
 *  a primeira ("db") é apenas com intuito de diminuir o singleton do FirebaseFirestore, 
 *  a segunda ("users") se trata de uma variável do tipo "CollectionReference" que pega a referência da collection('users').
 * 
 * O retorno do Widget é um FutureBuilder do tipo DocumentSnapshot, classe que contém dados lidos de um documento do banco de dados, já que estamos trabalhando com dados que precisam ser importados para depois ser construído.
 * Então utilizando dois parâmetros dele que o primeiro é o future e depois o builder.
 *  - O future recebe como dado uma função padrão do tipo Future do próprio firebaseFirestore que retorna um Objeto
 *    de uma collection através de um id RECEBIDA POR PARÂMETRO, neste caso a collection("users").
 * 
 *  - O builder é o responsável pelo snapshot do banco de dados, então quando a conexão é finalizada criamos uma variável
 *    para armazenar os dados do banco de dados e transformar em um map;
 */

/** ENTENDENDO O SNAPSHOT DO BUILDER
 * 
 * O snapshot do builder assume o método then, como exemplificado abaixo:
 *  
 * Note que o .then(...) retorna o mesmo dado que o snapshot retorna, o "id" e o "data()", este retorna uma classe Object, é necessário conveter para Map para a devida manipulação, 
 * ou string se quiser exibir todo o formato {...}.
 * 
 *  Future aprendendo() async {
      await FirebaseFirestore.instance.collection('users').get().then((event) {
        for (var doc in event.docs) {
          final data = jsonEncode(doc.data().toString());
          debugPrint("${doc.id} => ${doc.data()}" + "${jsonDecode(data)}");
        }
      });
    }
 * 
 * 
 */