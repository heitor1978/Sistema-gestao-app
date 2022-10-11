import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistemagestao_app/Theme/theme.dart';

class AlternateRoutes extends StatefulWidget {
  const AlternateRoutes({super.key});

  @override
  State<AlternateRoutes> createState() => _AlternateRoutesState();
}

class _AlternateRoutesState extends State<AlternateRoutes> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rotas Fixas",
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
              padding: EdgeInsets.fromLTRB(15, 15, 15, 7),
              child: Card(
                shadowColor: Colors.black,
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
                        Icons.route_outlined,
                        color: Colors.red[600],
                        size: 27,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Rotas Principais",
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
                      "1 -(Cedral)Av.Jucelino Tankevi",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.black,
                      ),
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
