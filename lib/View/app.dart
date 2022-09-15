import 'package:flutter/material.dart';
import 'package:sistemagestao_app/View/Routes/routes.dart';
import 'package:sistemagestao_app/View/export_all_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
      //home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
