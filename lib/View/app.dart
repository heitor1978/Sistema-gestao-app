import 'package:flutter/material.dart';
import 'package:sistemagestao_app/View/AlternateRoutes/Alternate_Routes.dart';
import 'package:sistemagestao_app/View/CheckScreen/check_screen.dart';
import 'package:sistemagestao_app/View/Documents/documents.dart';
import 'package:sistemagestao_app/View/Routes/routes.dart';
import 'package:sistemagestao_app/View/export_all_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //home: Login(),
      home: Home(),
      //home: CheckScreen(),
      //home: AlternateRoutes(),
      //home: Documents(),
      debugShowCheckedModeBanner: false,
    );
  }
}
