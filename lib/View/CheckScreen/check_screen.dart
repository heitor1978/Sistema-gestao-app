import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistemagestao_app/Theme/theme.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
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
                    CheckboxListTile(
                      activeColor: colorLetters,
                      title: Text(
                        "Calibragem Volante",
                        style: GoogleFonts.poppins(
                          color: colorLetters,
                        ),
                      ),
                      value: false,
                      onChanged: (value) {},
                    ),
                    CheckboxListTile(
                      activeColor: colorLetters,
                      title: Text(
                        "Sistema de Suspensão",
                        style: GoogleFonts.poppins(
                          color: colorLetters,
                        ),
                      ),
                      value: true,
                      onChanged: (value) {},
                    ),
                    CheckboxListTile(
                      activeColor: colorLetters,
                      title: Text(
                        "Oléo Motor",
                        style: GoogleFonts.poppins(
                          color: colorLetters,
                        ),
                      ),
                      value: false,
                      onChanged: (value) {},
                    ),
                    CheckboxListTile(
                      activeColor: colorLetters,
                      title: Text(
                        "Filtro de combustivel",
                        style: GoogleFonts.poppins(
                          color: colorLetters,
                        ),
                      ),
                      value: true,
                      onChanged: (value) {},
                    ),
                    CheckboxListTile(
                      activeColor: colorLetters,
                      title: Text(
                        "Sistema de Sinalização",
                        style: GoogleFonts.poppins(
                          color: colorLetters,
                        ),
                      ),
                      value: true,
                      onChanged: (value) {},
                    ),
                    CheckboxListTile(
                      activeColor: colorLetters,
                      title: Text(
                        "Sistema de Freio",
                        style: GoogleFonts.poppins(
                          color: colorLetters,
                        ),
                      ),
                      value: false,
                      onChanged: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
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
                margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
                //color: primaryColor,
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.fact_check_outlined,
          size: 35,
        ),
      ),
    );
  }
}
