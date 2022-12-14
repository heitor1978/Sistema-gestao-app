import 'package:flutter/material.dart';
import 'package:sistemagestao_app/Services/AuthService/auth_service.dart';
import 'package:sistemagestao_app/View/export_all_view.dart';
import 'package:sistemagestao_app/theme/theme.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AuthService auth = AuthService();
  String? user = "Carregando";
  String? email = "Carregando";

  @override
  void initState() {
    super.initState();
    auth;
    user = auth.userName;
    email = auth.getUserEmail();
  }

  setNome() async {
    await auth.setUserName();
    setState(() {
      user = auth.getUserName();
    });
  }

  getFirtsLastLetterFullName() {
    setNome();
    var firstLetterFirstName = user!.split("").first;
    var lastName = user!.split(" ").last;
    var firstLetterLastName = lastName.split("").first;

    return firstLetterFirstName + firstLetterLastName;
  }

  void _logOut(context) {
    AuthService().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 40,
                        minRadius: 35,
                        child: Text(
                          getFirtsLastLetterFullName(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 240, 240, 240),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                auth.userName!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                email.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 123, 123, 123),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  title: const Text(
                    "Home",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.house,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    "Lista de Rotas",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.map,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListRoutes(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    "Registro de Ocorr??ncia",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.draw,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Occurrence(),
                      ),
                    );
                  },
                ),
                /*ListTile(
                  title: const Text(
                    "Documenta????es",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.document_scanner,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Documents(),
                      ),
                    );
                  },
                ),*/
                ListTile(
                  title: const Text(
                    "Lista de Checklist",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.checklist,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Occurrence(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Deslogar",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Icon(
                  Icons.logout_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
            onTap: () {
              _logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
