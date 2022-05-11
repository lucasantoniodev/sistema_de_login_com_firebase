import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserDetailsService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  static final AddUserDetailsService instance = AddUserDetailsService._();
  AddUserDetailsService._();

  Future addUserDetails(
    String firstName,
    String lastName,
    String email,
    String age,
  ) async {
    await db.collection('users').add(
      {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "age": int.parse(age),
      },
    ).then(
      (value) => debugPrint('DocumentSnapshot added with ID: ${value.id}'),
    );
  }

  Future addUserDetailsWithID(
    String firstName,
    String lastName,
    String email,
    String age,
    int id,
  ) async {
    await db.collection('users').doc(id.toString()).set(
      {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "age": int.parse(age),
      },
    ).onError((error, _) => debugPrint(error.toString()));
  }
}

/** Classe responsável por adicionar usuários na collection("users") do banco de dados do Firebase
 * 
 * Começa com a criação de uma variável ("db") criada com intuito de diminuir o código do singleton do FirebaseFirestore;
 * 
 * Criado uma instância privada, transformando a classe em um singleton com o intuito de facilitar o uso da classe e impedir a sua instância por fora;
 * 
 * Por fim, criado dois métodos:
 *  - O Future "addUserDetails" que recebe parâmetros e adiciona um objeto/map a collection('users') e finaliza retornando um ID ALEATÓRIO
 *  que se refere ao objeto criado. 
 * 
 * - E por fim, o "addUserDetailsWithID" que funciona da mesma maneira porém com métodos diferente e com a finalidade principal de adicionar um ID ESPECÍFICO.
 */
