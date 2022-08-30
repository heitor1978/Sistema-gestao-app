import 'package:flutter/material.dart';
import 'package:sistemagestao_app/Services/AuthService/auth_service.dart';

import 'package:sistemagestao_app/View/export_all_view.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  AuthService auth = AuthService();
  bool isLoading = true;
  String? route;

  setRoute() {
    setState(() {
      route = auth.getRoute();
      isLoading = false;
    });
  }

  getRoute() async {
    setState(() => isLoading = true);
    await auth.setRoute();
    setRoute();
  }

  @override
  Widget build(BuildContext context) {
        while (isLoading) {
      getRoute();
      while (route == "") {
        setRoute();
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return MaterialApp(
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const Home(),
      },
      initialRoute: route,
      debugShowCheckedModeBanner: false,
    );
  }
}
