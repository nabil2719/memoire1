import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/comptepatient.dart';
import 'package:memoire00/documentpatient.dart';
import 'package:memoire00/fixeRVpatient.dart';
import 'package:memoire00/infopatient.dart';
import 'package:memoire00/infossurvotremedecin.dart';
import 'package:memoire00/symptome.dart';
import 'package:memoire00/traitement.dart';

class profile_patient extends StatefulWidget {
  @override
  State<profile_patient> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<profile_patient> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Profile de patient"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => comptepatient(),
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
                Navigator.of(context).pushReplacementNamed("comptepatient");
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
                          .collection("patient")
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
                          .collection("patient")
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
              SizedBox(
                height: 8.0,
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 150),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("patient")
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
                        'poster votre document',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        'anapath || lettre || orientation',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => documentpatient()),
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
                        'Patient info',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => infopatient(),
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
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              //start
              Container(
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
                              if (data["encours"] == "active") {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Card(
                                      margin: EdgeInsets.all(0.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.document_scanner,
                                          color: Colors.red[800],
                                        ),
                                        title: Text(
                                          'votre historique',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'historique',
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
                                                    traitement(),
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
                                      height: 8.0,
                                    ),
                                    Card(
                                      margin: EdgeInsets.all(0.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.schedule_outlined,
                                          color: Colors.black54,
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
                                          'consultation',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => fixeRV(),
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
                                      height: 8.0,
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Card(
                                      margin: EdgeInsets.all(0.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.schedule,
                                          color: Colors.black87,
                                        ),
                                        title: Text(
                                          'déposer les symptomes',
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
                                                builder: (context) =>
                                                    symptome(),
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
                                      height: 8.0,
                                    ),
                                    Card(
                                      margin: EdgeInsets.all(0.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.info,
                                          color: Colors.black87,
                                        ),
                                        title: Text(
                                          'Infos sur votre médecin',
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
                                                builder: (context) =>
                                                    infosurvotrmedecin(),
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
                                  ],
                                );
                              }
                              return null;
                            });
                      }
                      return CircularProgressIndicator();
                    }),
              )

              //end
            ],
          ),
        ),
      ),
    );
  }
}
