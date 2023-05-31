import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilemedecin.dart';
import 'package:http/http.dart' as http;

class fixedatechimio extends StatefulWidget {
  const fixedatechimio({super.key});

  @override
  State<fixedatechimio> createState() => _fixedatechimioState();
}

class _fixedatechimioState extends State<fixedatechimio> {
  TextEditingController jour = new TextEditingController();
  TextEditingController moins = new TextEditingController();
  TextEditingController annee = new TextEditingController();
  TextEditingController heure = new TextEditingController();
  TextEditingController salle = new TextEditingController();
  String search = "";
  CollectionReference userReff000 =
      FirebaseFirestore.instance.collection("patient");

  CollectionReference userReff00 =
      FirebaseFirestore.instance.collection("medecin");
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
          'chimio',
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

                            return Column(
                              children: [
                                Container(
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
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, i) {
                                              var data1 =
                                                  snapshot.data!.docs[i];

                                              if (data["email"] == search ||
                                                  search == "") {
                                                if (userReff00.doc(
                                                        data["emailmedecin"]) ==
                                                    userReff00
                                                        .doc(data1["email"])) {
                                                  if (userReff000
                                                          .doc(data["chimio1"])
                                                          .path ==
                                                      "patient/ok") {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Card(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  0.0),
                                                          child: ListTile(
                                                            leading: Icon(
                                                              Icons
                                                                  .person_add_alt,
                                                              color: Colors
                                                                  .red[800],
                                                            ),
                                                            title: Row(
                                                              children: [
                                                                Text(data[
                                                                    'nom']),
                                                                Text(" "),
                                                                Text(data[
                                                                    'prenon']),
                                                                Text(" "),
                                                                Text(
                                                                  data[
                                                                      'chimio'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
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
                                                            subtitle: Text(
                                                                data['email']),
                                                            trailing:
                                                                IconButton(
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
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(flex: 1, child: Container()),
                                                                                    Expanded(
                                                                                      flex: 4,
                                                                                      child: ElevatedButton(
                                                                                          onPressed: () async {
                                                                                            userReff000.doc(data.id).update({
                                                                                              "chimio": "prochaine",
                                                                                              "demande": "nondemande"
                                                                                            });
                                                                                            await http.post(
                                                                                              Uri.parse('https://fcm.googleapis.com/fcm/send'),
                                                                                              headers: <String, String>{
                                                                                                'Content-Type': 'application/json ; charset=UTF-8',
                                                                                                'Authorization': 'key=AAAA7AAFiK8:APA91bElHqaLN-U0ce4pl4kpvLfDZs5sO9mXw0EGOAmAq2ljv7vimKRQb4jT2z3E77PeuFFrjXprOngX8lHIegiWxOeZiTPBG6AxhaSFrNwOFVjzH3vxtU4PzIdJ0f0gNDYCkv8pWe7b',
                                                                                              },
                                                                                              body: jsonEncode(
                                                                                                <String, dynamic>{
                                                                                                  'notification': <String, dynamic>{
                                                                                                    'body': 'votre séance de chimio est verifier en attente la prochaine',
                                                                                                    'title': "chimiothérapie"
                                                                                                  },
                                                                                                  'priority': 'high',
                                                                                                  'data': <String, dynamic>{
                                                                                                    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                                                                                                  },
                                                                                                  'to': data["token"]
                                                                                                },
                                                                                              ),
                                                                                            );
                                                                                            Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) => fixedatechimio(),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          child: Text("valider"),
                                                                                          style: ElevatedButton.styleFrom(primary: Colors.red, shadowColor: Colors.red, elevation: 10)),
                                                                                    ),
                                                                                    Expanded(flex: 1, child: Container()),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(flex: 1, child: Container()),
                                                                                  Expanded(
                                                                                    flex: 5,
                                                                                    child: ElevatedButton(
                                                                                        onPressed: () {
                                                                                          showDialog(
                                                                                              context: context,
                                                                                              builder: (context) {
                                                                                                return AlertDialog(
                                                                                                  content: Container(
                                                                                                    height: 250,
                                                                                                    child: Column(
                                                                                                      children: [
                                                                                                        Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Expanded(
                                                                                                              flex: 6,
                                                                                                              child: Container(
                                                                                                                padding: EdgeInsets.only(left: 5),
                                                                                                                width: 40,
                                                                                                                child: TextFormField(
                                                                                                                  controller: jour,
                                                                                                                  keyboardType: TextInputType.number,
                                                                                                                  cursorColor: Colors.red,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    filled: true,
                                                                                                                    labelStyle: TextStyle(color: Color.fromARGB(93, 0, 0, 0), fontSize: 15, fontWeight: FontWeight.w400),
                                                                                                                    labelText: "jour",
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Expanded(flex: 1, child: Container()),
                                                                                                            Expanded(
                                                                                                              flex: 6,
                                                                                                              child: Container(
                                                                                                                padding: EdgeInsets.only(right: 5),
                                                                                                                width: 40,
                                                                                                                child: TextFormField(
                                                                                                                  controller: moins,
                                                                                                                  keyboardType: TextInputType.name,
                                                                                                                  cursorColor: Colors.red,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    filled: true,
                                                                                                                    labelStyle: TextStyle(color: Color.fromARGB(93, 0, 0, 0), fontSize: 15, fontWeight: FontWeight.w400),
                                                                                                                    labelText: "moins",
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Expanded(flex: 1, child: Container()),
                                                                                                            Expanded(
                                                                                                              flex: 6,
                                                                                                              child: Container(
                                                                                                                padding: EdgeInsets.only(right: 5),
                                                                                                                width: 40,
                                                                                                                child: TextFormField(
                                                                                                                  controller: annee,
                                                                                                                  keyboardType: TextInputType.number,
                                                                                                                  cursorColor: Colors.red,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    filled: true,
                                                                                                                    labelStyle: TextStyle(color: Color.fromARGB(93, 0, 0, 0), fontSize: 15, fontWeight: FontWeight.w400),
                                                                                                                    labelText: "année",
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Container(
                                                                                                          child: Text(""),
                                                                                                        ),
                                                                                                        Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Expanded(
                                                                                                              flex: 6,
                                                                                                              child: Container(
                                                                                                                padding: EdgeInsets.only(left: 5),
                                                                                                                width: 40,
                                                                                                                child: TextFormField(
                                                                                                                  controller: heure,
                                                                                                                  keyboardType: TextInputType.number,
                                                                                                                  cursorColor: Colors.red,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    filled: true,
                                                                                                                    labelStyle: TextStyle(color: Color.fromARGB(93, 0, 0, 0), fontSize: 15, fontWeight: FontWeight.w400),
                                                                                                                    labelText: "heure",
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Expanded(flex: 1, child: Container()),
                                                                                                            Expanded(
                                                                                                              flex: 6,
                                                                                                              child: Container(
                                                                                                                padding: EdgeInsets.only(right: 5),
                                                                                                                width: 40,
                                                                                                                child: TextFormField(
                                                                                                                  controller: salle,
                                                                                                                  keyboardType: TextInputType.name,
                                                                                                                  cursorColor: Colors.red,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color.fromARGB(114, 0, 0, 0), width: 2)),
                                                                                                                    filled: true,
                                                                                                                    labelStyle: TextStyle(color: Color.fromARGB(93, 0, 0, 0), fontSize: 15, fontWeight: FontWeight.w400),
                                                                                                                    labelText: "salle",
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Container(
                                                                                                          child: Text(""),
                                                                                                        ),
                                                                                                        ElevatedButton(
                                                                                                            onPressed: () async {
                                                                                                              var jour1 = jour.text;
                                                                                                              var moins1 = moins.text;
                                                                                                              var annee1 = annee.text;
                                                                                                              var heure1 = heure.text;
                                                                                                              var salle1 = salle.text;
                                                                                                              userReff000.doc(data.id).collection("chimio").add({
                                                                                                                "jour": jour1,
                                                                                                                "moins": moins1,
                                                                                                                "année": annee1,
                                                                                                                "heure": heure1,
                                                                                                                "salle": salle1,
                                                                                                              });
                                                                                                              userReff000.doc(data.id).update({
                                                                                                                "chimio": "en attente",
                                                                                                              });
                                                                                                              await http.post(
                                                                                                                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                                                                                                                headers: <String, String>{
                                                                                                                  'Content-Type': 'application/json ; charset=UTF-8',
                                                                                                                  'Authorization': 'key=AAAA7AAFiK8:APA91bElHqaLN-U0ce4pl4kpvLfDZs5sO9mXw0EGOAmAq2ljv7vimKRQb4jT2z3E77PeuFFrjXprOngX8lHIegiWxOeZiTPBG6AxhaSFrNwOFVjzH3vxtU4PzIdJ0f0gNDYCkv8pWe7b',
                                                                                                                },
                                                                                                                body: jsonEncode(
                                                                                                                  <String, dynamic>{
                                                                                                                    'notification': <String, dynamic>{
                                                                                                                      'body': 'votre séance chimio a été fixer',
                                                                                                                      'title': "séance chimio"
                                                                                                                    },
                                                                                                                    'priority': 'high',
                                                                                                                    'data': <String, dynamic>{
                                                                                                                      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                                                                                                                    },
                                                                                                                    'to': data["token"]
                                                                                                                  },
                                                                                                                ),
                                                                                                              );

                                                                                                              Navigator.push(
                                                                                                                context,
                                                                                                                MaterialPageRoute(
                                                                                                                  builder: (context) => profilemedecin(),
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                            child: Text("envoyer"),
                                                                                                            style: ElevatedButton.styleFrom(primary: Colors.red, shadowColor: Colors.red, elevation: 10))
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              });
                                                                                        },
                                                                                        child: Text("choisir un date chimio"),
                                                                                        style: ElevatedButton.styleFrom(primary: Colors.red, shadowColor: Colors.red, elevation: 10)),
                                                                                  ),
                                                                                  Expanded(flex: 1, child: Container()),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(flex: 1, child: Container()),
                                                                                  Expanded(
                                                                                    flex: 4,
                                                                                    child: ElevatedButton(
                                                                                        onPressed: () async {
                                                                                          userReff000.doc(data.id).update({
                                                                                            "chimio1": "terminer",
                                                                                            "chimio": "terminer"
                                                                                          });
                                                                                          await http.post(
                                                                                            Uri.parse('https://fcm.googleapis.com/fcm/send'),
                                                                                            headers: <String, String>{
                                                                                              'Content-Type': 'application/json ; charset=UTF-8',
                                                                                              'Authorization': 'key=AAAA7AAFiK8:APA91bElHqaLN-U0ce4pl4kpvLfDZs5sO9mXw0EGOAmAq2ljv7vimKRQb4jT2z3E77PeuFFrjXprOngX8lHIegiWxOeZiTPBG6AxhaSFrNwOFVjzH3vxtU4PzIdJ0f0gNDYCkv8pWe7b',
                                                                                            },
                                                                                            body: jsonEncode(
                                                                                              <String, dynamic>{
                                                                                                'notification': <String, dynamic>{
                                                                                                  'body': 'votre chimio a été terminer ',
                                                                                                  'title': "bonne santé"
                                                                                                },
                                                                                                'priority': 'high',
                                                                                                'data': <String, dynamic>{
                                                                                                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                                                                                                },
                                                                                                'to': data["token"]
                                                                                              },
                                                                                            ),
                                                                                          );
                                                                                          Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                              builder: (context) => profilemedecin(),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: Text("terminer"),
                                                                                        style: ElevatedButton.styleFrom(primary: Colors.red, shadowColor: Colors.red, elevation: 10)),
                                                                                  ),
                                                                                  Expanded(flex: 1, child: Container()),
                                                                                ],
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
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Container(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              50,
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                      child: StreamBuilder(
                                                                          stream: FirebaseFirestore.instance.collection("patient").doc(data.id).collection("chimio").snapshots(),
                                                                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              return ListView.builder(
                                                                                  itemCount: snapshot.data!.docs.length,
                                                                                  shrinkWrap: true,
                                                                                  itemBuilder: (context, i) {
                                                                                    var data1 = snapshot.data!.docs[i];
                                                                                    return Container(
                                                                                      color: Colors.white,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(data1['jour'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text("/"),
                                                                                              Text(data1['moins'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text("/"),
                                                                                              Text(data1['année'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text("   "),
                                                                                              Text("Salle : ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text(data1['salle'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text("   "),
                                                                                              Text(' A: ', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text(data1['heure'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  });
                                                                            }
                                                                            return CircularProgressIndicator();
                                                                          }));
                                                                });
                                                          },
                                                          child: Text("chimio"),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors.red,
                                                            shadowColor:
                                                                Colors.red,
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
                                ),
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
      ),
    );
  }
}
