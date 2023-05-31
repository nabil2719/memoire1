import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/consulesymptome.dart';
import 'package:memoire00/historiqueRV.dart';
import 'package:memoire00/historiquechimio.dart';
import 'package:memoire00/profilepatient.dart';

class traitement extends StatefulWidget {
  @override
  State<traitement> createState() => _traitementState();
}

class _traitementState extends State<traitement> {
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
                builder: (context) => profile_patient(),
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
          "Traitement",
          style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 0.8,
                    color: Colors.grey[400],
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Votre Historiue',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 0.8,
                    color: Colors.grey[400],
                  )),
                ],
              ),
            ),
            StreamBuilder(
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
                          var data1 = snapshot.data!.docs[i];
                          return Column(
                            children: [
                              Card(
                                margin: EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: Colors.black87,
                                  ),
                                  title: Text(
                                    'Rendez vous',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'date Rendez vous',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => historiqueRV(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Card(
                                margin: EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: Colors.black87,
                                  ),
                                  title: Text(
                                    'consulter les dates de traitement',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'chimio || visite',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              historiquechimio(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Card(
                                margin: EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: Colors.black87,
                                  ),
                                  title: Text(
                                    'Symptome || consultation',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'votre syptome',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      if (data1["symptome"] == "yes" ||
                                          data1["symptome"] == "no" ||
                                          data1["symptome"] == "en attente") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                consulesymptome(),
                                          ),
                                        );
                                      }
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
                  }
                  return CircularProgressIndicator();
                })

            //start
          ],
        ),
      ),
    );
  }
}
