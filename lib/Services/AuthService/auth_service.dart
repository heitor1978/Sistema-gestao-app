import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistemagestao_app/Models/collaborator_model.dart';
import 'package:sistemagestao_app/View/export_all_view.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  User? user;
  String? userName = "Carregando";
  String? userPhone = "Carregando";
  String? userRoute = "";

  CollaboratorModel model = CollaboratorModel(
    admin: null,
    cpf: null,
    nome: null,
    telefone: null,
    uid: null,
  );

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      this.user = (user == null) ? null : user;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  setUserName() {
    if (userName != "Carregando") return null;
    firestore
        .collection("funcionarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((event) {
      userName = event['nome'] != null ? event['nome'].toString() : "erro";
    });
  }

  setUserPhone() {
    if (userPhone != "Carregando") return null;
    firestore
        .collection("funcionarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((event) {
      userPhone =
          event['telefone'] != null ? event['telefone'].toString() : "erro";
    });
  }

  getUserName() {
    return userName;
  }

  getUserPhone() {
    return userPhone;
  }

  getUserEmail() {
    return _auth.currentUser!.email;
  }

  getUid() {
    return _auth.currentUser!.uid;
  }

  login(String email, String senha, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      await _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Usuário não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }

    bool admin = false;
    await firestore
        .collection("funcionarios")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((event) {
      admin = event['admin'] ?? false;
    });

    if (admin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sua conta não pertence a este sistema")),
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Home()),
        (route) => false,
      );
    }
  }

  setCustomerModel() async {
    await firestore.collection("funcionarios").doc(getUid()).get().then((event) {
      model.nome = event['nome'];
      model.cpf = event['cpf'];
      model.telefone = event['telefone'];
      model.uid = event['uid'];
    });
  }

  getCustomerModel() {
    return model;
  }

  getRoute() {
    return userRoute;
  }

  setRoute() async {
    await _getUser();
    if (user == null) {
      userRoute = "/";
    } else {
      bool admin = false;
      await firestore
          .collection("funcionarios")
          .doc(user!.uid)
          .get()
          .then((event) {
        admin = event['admin'] ?? false;
      });
    }
  }

  logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  getInformationUser() {
    return firestore
        .collection("funcionarios")
        .where("uid", isEqualTo: _auth.currentUser!.uid)
        .snapshots();
  }
}
