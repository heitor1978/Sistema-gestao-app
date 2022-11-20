import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistemagestao_app/Theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistemagestao_app/View/ListRoutes/list_Routes.dart';
import 'package:sistemagestao_app/View/CheckScreen/check_screen.dart';
import 'package:sistemagestao_app/View/Documents/documents.dart';
import 'package:sistemagestao_app/View/Occurrence/occurrence.dart';
import 'package:sistemagestao_app/Widgets/export_all_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final TextEditingController _controllerReasonDenied = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? name;

  int indexNavigatorBar = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 227, 231),
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Olá, Seja Bem-Vindo"), //
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection('funcionarios')
            .doc(auth.currentUser!.uid)
            .collection('veiculo')
            .snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorCard,
                            borderRadius: BorderRadius.circular(15)),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(23, 10, 23, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      //"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-HmqnmKL4-cOvhmeevf2UbJwyKdJW5uUztg&usqp=CAU",
                                      "assets/images/CaminhaoMercedes.jpg",
                                      height: 50,
                                      width: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text(snapshot.data!.docs[index]
                                            ['placa']),
                                        Text(snapshot.data!.docs[index]
                                            ['versaoVeiculo'])
                                      ],
                                    ),
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Color.fromARGB(255, 55, 206, 58),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Seus Serviços",
                              style: GoogleFonts.poppins(
                                  fontSize: 22, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Veja Suas rotas, checkagem e visualização de arquivos",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => ListRoutes()),
                              (route) => false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorCard,
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/localization.png",
                                  height: 50,
                                  width: 50,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Rotas Previstas",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => Documents()),
                                (route) => false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: colorCard,
                                borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 100,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/pdf-file.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: Text(
                                          "Documentações",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => CheckScreen()),
                                (route) => false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: colorCard,
                                borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 100,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/check-box.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 0, 0),
                                        child: Text(
                                          "Checkagem",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CheckScreen(),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorCard,
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/check-box.png",
                                  height: 50,
                                  width: 50,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Checklist",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Occurrence(),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorCard,
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/localization.png",
                                  height: 50,
                                  width: 50,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Ocorrências",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
