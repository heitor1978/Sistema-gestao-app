import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sistemagestao_app/Theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistemagestao_app/View/ListRoutes/routes_view.dart';
import 'package:sistemagestao_app/Widgets/Drawer/custom_drawer.dart';

class ListRoutes extends StatefulWidget {
  const ListRoutes({super.key});

  @override
  State<ListRoutes> createState() => _ListRoutesState();
}

class _ListRoutesState extends State<ListRoutes> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  //snapshot.data.docs[index]['localizacaoAtual']['latitude']
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          "Rotas Fixas",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Padding(
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
          Flexible(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
                .collection('funcionarios')
                .doc(auth.currentUser!.uid)
                .collection('rotas')
                .snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return Container(
                        child: Padding(
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
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['nomeRota'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            GeoPoint geoPoint =
                                snapshot.data!.docs[index]['localizacaoAtual'];
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  //RoutesView(localizacaoEntrega: LatLng(geoPoint.("Latitude"), geoPoint("Longitude"))),
                                  RoutesView(
                                      localizacaoEntrega: LatLng(
                                          geoPoint.latitude,
                                          geoPoint.longitude)),
                            ));
                          },
                        ),
                      ),
                    ));
                  });
            },
          )),
        ],
      ),
    );
  }
}
