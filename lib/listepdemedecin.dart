import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilemedecin.dart';

class listepdemedecin extends StatefulWidget {
  const listepdemedecin({super.key});

  @override
  State<listepdemedecin> createState() => _listepdemedecinState();
}

class _listepdemedecinState extends State<listepdemedecin> {
  String search = "";
  CollectionReference userReff =
      FirebaseFirestore.instance.collection("patient");
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
          "Liste votre patients ",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("patient").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var data1 = snapshot.data!.docs[i];

                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("medecin")
                              .where("userid",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    var data = snapshot.data!.docs[i];

                                    if (data1['emailmedecin'] ==
                                        data['email']) {
                                      if (data1["email"] == search ||
                                          search == "") {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              margin: EdgeInsets.all(0.0),
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons
                                                      .person_remove_alt_1_outlined,
                                                  color: Colors.red[800],
                                                ),
                                                title: Row(
                                                  children: [
                                                    Text(data1['nom']),
                                                    Text(" "),
                                                    Text(data1['prenon']),
                                                    Text(" "),
                                                    Text(
                                                      data1['encours'],
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 255, 0, 0),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Text(data1['email']),
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
                                                                          flex:
                                                                              2,
                                                                          child: ElevatedButton(
                                                                              onPressed: () {
                                                                                userReff.doc(data1.id).delete();
                                                                              },
                                                                              child: Text("supprimer"),
                                                                              style: ElevatedButton.styleFrom(primary: Colors.red, shadowColor: Colors.red, elevation: 10)),
                                                                        ),
                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container()),
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
                                      }
                                    }
                                    return null;
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        );
                      });
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
