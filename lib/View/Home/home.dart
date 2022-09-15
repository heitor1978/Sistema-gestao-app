import 'package:flutter/material.dart';
import 'package:sistemagestao_app/Theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistemagestao_app/Widgets/export_all_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 227, 231),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Olá, David Guetta"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              //decoration: Border(bottom: Border.all(8)),
              color: colorCard,
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/caminhao.png",
                          height: 60,
                          width: 60,
                        ),
                        Column(
                          children: [Text("VLSK-3065"), Text("Scania C100")],
                        ),
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: Color.fromARGB(255, 55, 206, 58),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text("Alterar"),
                          style: ButtonStyle(
                              //backgroundColor: Color(),
                              ),
                        ),
                        TextButton(onPressed: () {}, child: Text("Remover")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
              onTap: () {},
              child: Container(
                color: colorCard,
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Row(
                  children: [
                    Image.asset("assets/images/localization.png"),
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
                        Row(
                          children: [Text("3 Rotas Previstas")],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  color: colorCard,
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 100,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/pdf-file.png",
                            width: 60,
                            height: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text("Documentações"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  color: colorCard,
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 100,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/check-box.png",
                            width: 60,
                            height: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text("Checkagem"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {},
              child: Container(
                color: colorCard,
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Row(
                  children: [
                    Image.asset("assets/images/localization.png"),
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
        ],
      ),
    );
  }
}
