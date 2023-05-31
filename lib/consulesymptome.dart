import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/traitement.dart';

class consulesymptome extends StatefulWidget {
  const consulesymptome({super.key});

  @override
  State<consulesymptome> createState() => _consulesymptomeState();
}

class _consulesymptomeState extends State<consulesymptome> {
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
                builder: (context) => traitement(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          ),
          color: const Color.fromARGB(255, 251, 251, 251),
        ),
        title: Text(
          "symptome",
          style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("patient")
                    .where("userid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          return Column(
                            children: [
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("patient")
                                      .doc(data.id)
                                      .collection("symptome")
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, i) {
                                            var data2 = snapshot.data!.docs[i];
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 50.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("pertepoid : ",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(data2['pertepoid'],
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("fiévre : ",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(data2['fiévre'],
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("fatigue : ",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(data2['fatigue'],
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("vomissement : ",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(data2['vomissement'],
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("battements : ",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(data2['battements'],
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                    return CircularProgressIndicator();
                                  }),
                              Container(
                                  width: 350,
                                  padding: EdgeInsets.only(
                                      top: 20, right: 40, left: 40),
                                  child: ElevatedButton(
                                    onPressed: (() async {
                                      print(data['symptome']);
                                      if (data['symptome'] == "en attente") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  height: 150,
                                                  width: 250,
                                                  child: StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection("patient")
                                                          .doc(data.id)
                                                          .collection(
                                                              "consultationapres")
                                                          .snapshots(),
                                                      builder: (context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                        if (snapshot.hasData) {
                                                          return ListView
                                                              .builder(
                                                                  itemCount:
                                                                      snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (context,
                                                                          i) {
                                                                    var data2 =
                                                                        snapshot
                                                                            .data!
                                                                            .docs[i];
                                                                    return Container(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                              'Rendez vous :',
                                                                              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900)),
                                                                          SizedBox(
                                                                            height:
                                                                                20.0,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(data2['jour'], style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                              Text("/"),
                                                                              Text(data2['moins'], style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                              Text("/"),
                                                                              Text(data2['année'], style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                15.0,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text("Salle : ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                              Text(data2['salle'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                15.0,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(' Heure: ', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                              Text(data2['heure'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  });
                                                        }
                                                        return CircularProgressIndicator();
                                                      }),
                                                ),
                                              );
                                            });
                                      }
                                      if (data["symptome"] == "no") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  content: Container(
                                                child: Text(data["remarque"],
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ));
                                            });
                                      }
                                      if (data["symptome"] == "yes")
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  content: Container(
                                                child: Text(
                                                    "en attente de réponse",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ));
                                            });
                                    }),
                                    child: Text("voir le Resultat"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        shadowColor: Colors.red,
                                        elevation: 10),
                                  )),
                            ],
                          );
                        });
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ),
      ),
    );
  }
}
