import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sistemagestao_app/Theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';

class DocumentsContainer extends StatelessWidget {
  DocumentsContainer({super.key});

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;


  Future getDocumentsDownload(String fileName) async {
    final storage = FirebaseStorage.instance.ref();
    final url = await storage.child('documentation/$fileName').getDownloadURL();
    final dir = await getApplicationDocumentsDirectory();
    final filePath = "Download/$fileName";
    await Dio().download(url , filePath);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore
                  .collection('funcionarios')
                  .doc(auth.currentUser!.uid)
                  .collection('documentacao')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (_, index) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              getDocumentsDownload(snapshot.data!.docs[index]['nomeArquivo']);
                            },
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
                                      snapshot.data!.docs[index]['nome'],
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
