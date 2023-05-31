import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memoire00/comptemedecin.dart';
import 'package:memoire00/fixedatechimio.dart';
import 'package:memoire00/infomedecin.dart';
import 'package:memoire00/listepatientdemandeRV.dart';
import 'package:memoire00/listepatientsignaler%20symptomz.dart';
import 'package:memoire00/listepdemedecin.dart';
import 'package:memoire00/termminetraitement.dart';

class profilemedecin extends StatefulWidget {
  @override
  State<profilemedecin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<profilemedecin> {
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Profile de medecin"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => comptemedecin(),
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
                Navigator.of(context).pushReplacementNamed("comptemedecin");
              }),
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
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
                          .collection("medecin")
                          .where("userid",
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          .collection("medecin")
                          .where("userid",
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 150),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("medecin")
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
                            return Text(
                              data['encours'],
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
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
                    'infos Médecin',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => infomedecin(),
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
                    'Liste leur patients',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => listepdemedecin(),
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
                    'Liste des patients qui demande rendez vous',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    'Programmer la 1ère scéance de consultation',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => listepatientdemandeRV(),
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
                    'Liste des patients prêt pour chimio',
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
                          builder: (context) => fixedatechimio(),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => fintraitement(),
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
              Card(
                margin: EdgeInsets.all(0.0),
                child: ListTile(
                  leading: Icon(
                    Icons.list_alt_outlined,
                    color: Colors.black87,
                  ),
                  title: Text(
                    'Liste des patients signaler symptômes',
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
                          builder: (context) => lisepatientsymptomes(),
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
      ),
    );
  }
}
