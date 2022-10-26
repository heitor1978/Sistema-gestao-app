import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistemagestao_app/Theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final TextEditingController _controller= TextEditingController();

  bool _ativado = false;
  bool _ativado1 = false;
  bool _ativado2 = false;
  bool _ativado3 = false;
  bool _ativado4 = false;
  bool _ativado5 = false;

  void save(BuildContext context) async {
    firestore.collection('funcionarios').doc(auth.currentUser!.uid).collection('checklist').doc().set({
      "nome": "Checklist do Dia",
      "observacaoChecklist": _controller.text,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.keyboard_return_rounded)),
        backgroundColor: primaryColor,
        title: Text(
          "Check List",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: [
              Container(
                // ignore: sort_child_properties_last
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Plano de Checkagem Preventiva",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Card(
                        child: Column(
                          children: [
                            CheckboxListTile(
                              activeColor: colorLetters,
                              title: Text(
                                "Calibragem Volante",
                                style: GoogleFonts.poppins(
                                  color: colorLetters,
                                ),
                              ),
                              value: _ativado,
                              onChanged: (value) {
                                setState(() {
                                  _ativado = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              activeColor: colorLetters,
                              title: Text(
                                "Sistema de Suspensão",
                                style: GoogleFonts.poppins(
                                  color: colorLetters,
                                ),
                              ),
                              value: _ativado1,
                              onChanged: (value){
                                setState(() {
                                  _ativado1 = value!;
                                });
                              },
                              
                            ),
                            CheckboxListTile(
                              activeColor: colorLetters,
                              title: Text(
                                "Oléo Motor",
                                style: GoogleFonts.poppins(
                                  color: colorLetters,
                                ),
                              ),
                              value: _ativado2,
                              onChanged: (value) {
                                setState(() {
                                  _ativado2 = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              activeColor: colorLetters,
                              title: Text(
                                "Filtro de combustivel",
                                style: GoogleFonts.poppins(
                                  color: colorLetters,
                                ),
                              ),
                              value: _ativado3,
                              onChanged: (value) {
                                setState(() {
                                  _ativado3 = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              activeColor: colorLetters,
                              title: Text(
                                "Sistema de Sinalização",
                                style: GoogleFonts.poppins(
                                  color: colorLetters,
                                ),
                              ),
                              value: _ativado4,
                              onChanged: (value) {
                                setState(() {
                                  _ativado4 = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              activeColor: colorLetters,
                              title: Text(
                                "Sistema de Freio",
                                style: GoogleFonts.poppins(
                                  color: colorLetters,
                                ),
                              ),
                              value: _ativado5,
                              onChanged: (value) {
                                setState(() {
                                  _ativado5 = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextField(
                        controller: _controller,
                        cursorColor: colorLetters,
                        autocorrect: true,
                        maxLines: 2,
                        style: TextStyle(
                          color: colorLetters,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: colorLetters,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: "Oléo do motor em falta",
                          hintStyle: TextStyle(
                            color: colorLetters,
                          ),
                          labelText: "Digite observações sobre a check list",
                          labelStyle: TextStyle(
                            color: colorLetters,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: colorLetters,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 79, 202, 239)),
                margin: EdgeInsets.fromLTRB(15, 20, 15, 40),
                //color: primaryColor,
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          save(context);
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.fact_check_outlined,
          size: 35,
        ),
      ),
    );
  }
}
