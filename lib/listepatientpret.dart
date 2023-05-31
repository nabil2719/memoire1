import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilesecretaire.dart';

class listepatientpret extends StatefulWidget {
  const listepatientpret({super.key});

  @override
  State<listepatientpret> createState() => _listepatientpretState();
}

CollectionReference userReff = FirebaseFirestore.instance.collection("patient");
CollectionReference userReff1 =
    FirebaseFirestore.instance.collection("medecin");

class _listepatientpretState extends State<listepatientpret> {
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
          "Liste des patients en cours",
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
                    .collection("patient")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          if (userReff.doc(data["encours"]).path ==
                              "patient/active") {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  margin: EdgeInsets.all(0.0),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.person_add_alt,
                                      color: Colors.red[800],
                                    ),
                                    title: Row(
                                      children: [
                                        Text(data['nom']),
                                        Text(" "),
                                        Text(data['prenon']),
                                        Text(" "),
                                        Text(
                                          data['verifier'],
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
                                                  height: 100,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
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
                                                                            .doc(data.id)
                                                                            .delete();
                                                                      },
                                                                      child: Text(
                                                                          "supprimer"),
                                                                      style: ElevatedButton.styleFrom(
                                                                          primary: Colors
                                                                              .red,
                                                                          shadowColor: Colors
                                                                              .red,
                                                                          elevation:
                                                                              10)),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Container()),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 1,
                                                              child:
                                                                  Container()),
                                                          Expanded(
                                                            flex: 5,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Container(
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                                                                                    child: StreamBuilder(
                                                                                      stream: FirebaseFirestore.instance.collection("medecin").snapshots(),
                                                                                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                                        if (snapshot.hasData) {
                                                                                          return ListView.builder(
                                                                                              itemCount: snapshot.data!.docs.length,
                                                                                              shrinkWrap: true,
                                                                                              itemBuilder: (context, i) {
                                                                                                var data1 = snapshot.data!.docs[i];
                                                                                                if (userReff1.doc(data1["encours"]).path == "medecin/active") {
                                                                                                  return Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Card(
                                                                                                        margin: EdgeInsets.all(0.0),
                                                                                                        child: ListTile(
                                                                                                          onTap: () {
                                                                                                            userReff.doc(data.id).update({
                                                                                                              "nommedecin": data1['nom'],
                                                                                                              "prenommedecin": data1['prenon'],
                                                                                                              "emailmedecin": data1['email'],
                                                                                                              "phonemedecin": data1['phone'],
                                                                                                              "verifier": "verifier",
                                                                                                              "useridmedecin": data1['userid'],
                                                                                                              "idmedecin": data1.id,
                                                                                                            });

                                                                                                            Navigator.push(
                                                                                                              context,
                                                                                                              MaterialPageRoute(
                                                                                                                builder: (context) => profile_secretaire(),
                                                                                                              ),
                                                                                                            );
                                                                                                          },
                                                                                                          leading: Icon(
                                                                                                            Icons.person_add,
                                                                                                            color: Colors.red[800],
                                                                                                          ),
                                                                                                          title: Row(
                                                                                                            children: [
                                                                                                              Text(data1['nom']),
                                                                                                              Text(" "),
                                                                                                              Text(data1['prenon']),
                                                                                                            ],
                                                                                                          ),
                                                                                                          subtitle: Text(data1['email']),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  );
                                                                                                } else {
                                                                                                  return Container(
                                                                                                    height: 200,
                                                                                                    child: Center(
                                                                                                      child: Text("il yas pas de medecin", style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 246, 246, 246), fontWeight: FontWeight.w500)),
                                                                                                    ),
                                                                                                  );
                                                                                                }
                                                                                              });
                                                                                        } else {
                                                                                          return CircularProgressIndicator();
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          });
                                                                    },
                                                                    child: Text(
                                                                        "choisir leur medecin"),
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
                                                        ],
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
                          }
                          return null;
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
