import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

import 'package:memoire00/profilepatient.dart';

class infopatient extends StatefulWidget {
  const infopatient({super.key});

  @override
  State<infopatient> createState() => _infopatientState();
}

class _infopatientState extends State<infopatient> {
  ////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////

  //basededonnés//////////////////////////////////////////////////////////////////

  //true/////////////////////////////////////////////////////////////////////
  String email = "";
  String password = "";
  String? nom = "";
  String prenom = "";
  String cnfmotdepass = "";
  String phone = "";
  String jour = "";
  String moins = "";
  String annees = "";
  String genre = "";
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
                builder: (context) => profile_patient(),
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
          'Votre information personnele ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 100, left: 20, right: 20),
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Nom : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              Text("  "),
                              Text(data['nom'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Prénom : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              Text("  "),
                              Text(data['prenon'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Email : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              Text(" "),
                              Text(data['email'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Numéro de téléphone : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              Text(" "),
                              Text(data['phone'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('date de naissance : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              Text(" "),
                              Text(data['jour'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              Text("/"),
                              Text(data['moins'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              Text("/"),
                              Text(data['annee'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
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
