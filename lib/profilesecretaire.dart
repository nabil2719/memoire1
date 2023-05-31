import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:memoire00/comptesecretaire.dart';
import 'package:memoire00/infosecretaire.dart';
import 'package:memoire00/listemedecin.dart';
import 'package:memoire00/listepatient.dart';
import 'package:memoire00/listepatientpret.dart';

class profile_secretaire extends StatefulWidget {
  @override
  State<profile_secretaire> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<profile_secretaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Profile d'admin"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => comptesecretaire(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          ),
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: (() async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed("comptesecretaire");
              }),
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.0,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
              color: Color.fromARGB(149, 255, 255, 255),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle_sharp,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                title: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("secretaire")
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(data['nom']),
                                  Text("  "),
                                  Text(data['prenon']),
                                ],
                              );
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                subtitle: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("secretaire")
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
                              return Text(data['email']);
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ),
            //start
            Card(
              margin: EdgeInsets.all(0.0),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                title: Text(
                  'Infos personnelles',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Infos admin',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => infosecretaire(),
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
              height: 3.0,
            ),

            Card(
              margin: EdgeInsets.all(0.0),
              child: ListTile(
                leading: Icon(
                  Icons.list_alt_outlined,
                  color: Colors.red[800],
                ),
                title: Text(
                  'liste des patients',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Avant le staff',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => listepatient(),
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
              height: 3.0,
            ),

            Card(
              margin: EdgeInsets.all(0.0),
              child: ListTile(
                leading: Icon(
                  Icons.list_alt_outlined,
                  color: Colors.black54,
                ),
                title: Text(
                  'Liste des patients en cours de traitement',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Apés le staff',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => listepatientpret(),
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
              height: 3.0,
            ),

            Card(
              margin: EdgeInsets.all(0.0),
              child: ListTile(
                leading: Icon(
                  Icons.list_alt_outlined,
                  color: Colors.black87,
                ),
                title: Text(
                  'Liste des patients ayant terminé le traitement',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  '',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 3.0,
            ),
            Card(
              margin: EdgeInsets.all(0.0),
              child: ListTile(
                leading: Icon(
                  Icons.list_alt_outlined,
                  color: Colors.black87,
                ),
                title: Text(
                  'Les médecins ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  '',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => listemedecin(),
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

            //end
          ],
        ),
      ),
    );
  }
}
