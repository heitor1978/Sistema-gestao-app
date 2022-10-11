import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistemagestao_app/Theme/theme.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Documentos",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.keyboard_return_rounded)),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                )),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        Icons.document_scanner_outlined,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Documentações",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: colorCard,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: colorCard,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topRight: Radius.circular(0),
                topLeft: Radius.circular(0),
              )),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      "Documento caminhão Scania CLI 100",
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
