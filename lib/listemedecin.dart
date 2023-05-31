import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilesecretaire.dart';

class listemedecin extends StatefulWidget {
  const listemedecin({super.key});

  @override
  State<listemedecin> createState() => _listemedecinState();
}

CollectionReference userReff = FirebaseFirestore.instance.collection("medecin");
String? oriente;

class _listemedecinState extends State<listemedecin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => profile_secretaire(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          ),
          color: Colors.white,
        ),
        title: Text(
          "Liste des medecins",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("medecin")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                margin: EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.person_remove_alt_1_outlined,
                                    color: Colors.red[800],
                                  ),
                                  title: Row(
                                    children: [
                                      Text(data['nom']),
                                      Text(" "),
                                      Text(data['prenon']),
                                      Text(" "),
                                      Text(
                                        data['encours'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: const Color.fromARGB(
                                                255, 255, 0, 0),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(data['email']),
                                  trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Container(
                                                height: 60,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      userReff
                                                                          .doc(data
                                                                              .id)
                                                                          .delete();
                                                                    },
                                                                    child: Text(
                                                                        "supprimer"),
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            Colors
                                                                                .red,
                                                                        shadowColor:
                                                                            Colors
                                                                                .red,
                                                                        elevation:
                                                                            10)),
                                                          ),
                                                          Expanded(
                                                              flex: 1,
                                                              child:
                                                                  Container()),
                                                          Expanded(
                                                            flex: 2,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      userReff
                                                                          .doc(data
                                                                              .id)
                                                                          .update({
                                                                        "encours":
                                                                            "active"
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                        "valider"),
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            Colors
                                                                                .red,
                                                                        shadowColor:
                                                                            Colors
                                                                                .red,
                                                                        elevation:
                                                                            10)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
