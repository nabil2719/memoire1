import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilemedecin.dart';

class fintraitement extends StatefulWidget {
  const fintraitement({super.key});

  @override
  State<fintraitement> createState() => _fintraitementState();
}

class _fintraitementState extends State<fintraitement> {
  CollectionReference userReff000 =
      FirebaseFirestore.instance.collection("patient");

  CollectionReference userReff00 =
      FirebaseFirestore.instance.collection("medecin");
  String search = "";
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
                builder: (context) => profilemedecin(),
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
          'fin de traitement',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
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

                            return Container(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("medecin")
                                    .where("userid",
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, i) {
                                          var data1 = snapshot.data!.docs[i];
                                          if (data["emailmedecin"] ==
                                              data1["email"]) {
                                            if (data["chimio1"] == "terminer") {
                                              if (data["email"] == search ||
                                                  search == "") {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Card(
                                                      margin:
                                                          EdgeInsets.all(0.0),
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.person_add_alt,
                                                          color:
                                                              Colors.red[800],
                                                        ),
                                                        title: Row(
                                                          children: [
                                                            Text(data['nom']),
                                                            Text(" "),
                                                            Text(
                                                                data['prenon']),
                                                            Text(" "),
                                                            Text(
                                                              data['chimio1'],
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      255,
                                                                      0,
                                                                      0),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        subtitle:
                                                            Text(data['email']),
                                                        trailing: IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    content:
                                                                        Container(
                                                                      height:
                                                                          150,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(flex: 1, child: Container()),
                                                                                Expanded(
                                                                                  flex: 4,
                                                                                  child: ElevatedButton(
                                                                                      onPressed: () {
                                                                                        userReff000.doc(data.id).delete();
                                                                                        ;
                                                                                        Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                            builder: (context) => fintraitement(),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      child: Text("supprimer"),
                                                                                      style: ElevatedButton.styleFrom(primary: Colors.red, shadowColor: Colors.red, elevation: 10)),
                                                                                ),
                                                                                Expanded(flex: 1, child: Container()),
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
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                            }
                                          }
                                          return null;
                                        });
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
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
      ),
    );
  }
}
