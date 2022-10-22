import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistemagestao_app/Theme/theme.dart';
import 'package:sistemagestao_app/View/Documents/documents_container.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;
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
              onPressed: () {}, icon: Icon(Icons.keyboard_return_rounded)),
        ),
        body: PageView(
          onPageChanged: (int page) {
            setState(() {
              indexNavigatorBar = page;
            });
          },
          controller: _pageController,
          children: [
            DocumentsContainer(),
          ],
        ));
  }
}
