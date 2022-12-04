import 'package:flutter/material.dart';
import 'package:sistemagestao_app/Theme/theme.dart';
import 'package:sistemagestao_app/Widgets/export_all_widget.dart';
import 'package:sistemagestao_app/Services/Validators/user_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Occurrence extends StatefulWidget {
  const Occurrence({super.key});

  @override
  State<Occurrence> createState() => _OccurrenceState();
}

class _OccurrenceState extends State<Occurrence> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? occurrenceName = '', occurrenceRegister = '';

  final TextEditingController _controllerOcurrenceName =
      TextEditingController();
  final TextEditingController _controllerOcurrenceRegister =
      TextEditingController();

  void save(BuildContext context) async {
    final now = DateTime.now();
    var day = now.day;
    var month = now.month;
    var year = now.year;
    var hour = now.hour;
    var minute = now.minute;
    var second = now.second;

    firestore
        .collection('funcionarios')
        .doc(auth.currentUser!.uid)
        .collection('ocorrencia')
        .doc()
        .set({
      "nomeOcorrencia": _controllerOcurrenceName.text,
      "registroOcorrencia": _controllerOcurrenceRegister.text,
      "datahora": "$day/$month/$year - $hour:$minute:$second",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Ocorrências"),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.keyboard_return_rounded)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: CustomTextField(
                labelText: "Nome da Ocorrência",
                placeholder: "Nome da Ocorrência",
                obscureText: false,
                onSaved: (value) => occurrenceName = value,
                validator: (value) => UserValidator.validarNome(value!),
                controller: _controllerOcurrenceName,
              ),
            ),
            CustomTextField(
              labelText: "Registro da Ocorrência",
              placeholder: "Farol Queimado",
              obscureText: false,
              onSaved: (value) => occurrenceRegister = value,
              validator: (value) =>
                  UserValidator.validarRegistroOcorrencia(value!),
              controller: _controllerOcurrenceRegister,
            ),
            CustomTextButton(
              buttonText: "Registrar",
              onPressed: () {
                save(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
