import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilesecretaire.dart';

class listepatient extends StatefulWidget {
  const listepatient({super.key});

  @override
  State<listepatient> createState() => _listepatientState();
}

class _listepatientState extends State<listepatient> {
  String? oriente;

  CollectionReference userReff =
      FirebaseFirestore.instance.collection("patient");
  String search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
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
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        title: Text(
          "Liste des patients avant le",
          style: TextStyle(
              color: const Color.fromARGB(255, 240, 240, 240),
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                keyboardType: TextInputType.name,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                  filled: true,
                  labelStyle: TextStyle(
                      color: Color.fromARGB(93, 0, 0, 0),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  labelText: "Rechercher",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
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
                          if (data["inscrit"] == "inscrit") {
                            if (data["email"] == search || search == "") {
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
                                            data['valider'],
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
                                                                            primary:
                                                                                Colors.red,
                                                                            shadowColor: Colors.red,
                                                                            elevation: 10)),
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
                                                                                "vers le bloc radio thérapie"
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                            "orienté"),
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                Colors.red,
                                                                            shadowColor: Colors.red,
                                                                            elevation: 10)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              userReff
                                                                  .doc(data.id)
                                                                  .update({
                                                                "valider":
                                                                    "valider",
                                                                "encours":
                                                                    "active"
                                                              });
                                                            },
                                                            child:
                                                                Text("activer"),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        Colors
                                                                            .red,
                                                                    shadowColor:
                                                                        Colors
                                                                            .red,
                                                                    elevation:
                                                                        10)),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Container(
                                                    child: Image.network(
                                                      "${data['lettreorientation']}",
                                                      fit: BoxFit.contain,
                                                      height: 300,
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text("lettre"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          shadowColor: Colors.red,
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 1,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Container(
                                                    child: Image.network(
                                                      "${data['anapath']}",
                                                      fit: BoxFit.contain,
                                                      height: 300,
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text("anapath"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          shadowColor: Colors.red,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              );
                            }
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
