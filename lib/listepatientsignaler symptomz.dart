import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilemedecin.dart';

class lisepatientsymptomes extends StatefulWidget {
  const lisepatientsymptomes({super.key});

  @override
  State<lisepatientsymptomes> createState() => _lisepatientsymptomesState();
}

class _lisepatientsymptomesState extends State<lisepatientsymptomes> {
  TextEditingController jour = new TextEditingController();
  TextEditingController moins = new TextEditingController();
  TextEditingController annee = new TextEditingController();
  TextEditingController heure = new TextEditingController();
  TextEditingController salle = new TextEditingController();
  CollectionReference userReff000 =
      FirebaseFirestore.instance.collection("patient");
  String search = "";
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
          'patient signale symptomes ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.0),
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
            Container(
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

                                        if (userReff00
                                                .doc(data["emailmedecin"]) ==
                                            userReff00.doc(data1["email"])) {
                                          if (data['symptome'] == "yes" ||
                                              data['symptome'] ==
                                                  "en attente") {
                                            if (data["chimio"] == "prochaine") {
                                              if (data["email"] == search ||
                                                  search == "") {
                                                return StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("patient")
                                                        .doc(data.id)
                                                        .collection("symptome")
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        return ListView.builder(
                                                            itemCount: snapshot
                                                                .data!
                                                                .docs
                                                                .length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context, i) {
                                                              var data2 =
                                                                  snapshot.data!
                                                                      .docs[i];
                                                              print(data2[
                                                                      "symptome"] ==
                                                                  "yes");
                                                              if (data2[
                                                                      "symptome"] ==
                                                                  "yes") {
                                                                return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Card(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              0.0),
                                                                      child:
                                                                          ListTile(
                                                                        leading:
                                                                            Icon(
                                                                          Icons
                                                                              .person_add_alt,
                                                                          color:
                                                                              Colors.red[800],
                                                                        ),
                                                                        title:
                                                                            Row(
                                                                          children: [
                                                                            Text(data['nom']),
                                                                            Text(" "),
                                                                            Text(data['prenon']),
                                                                            Text(" "),
                                                                            Text(
                                                                              data['symptome'],
                                                                              style: TextStyle(fontSize: 10, color: const Color.fromARGB(255, 255, 0, 0), fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        subtitle:
                                                                            Text(data['email']),
                                                                        trailing:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return AlertDialog(
                                                                                    content: Container(
                                                                                      height: 300,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text("pertepoid : ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text(data2['pertepoid'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text("fiévre : ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text(data2['fiévre'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text("fatigue : ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text(data2['fatigue'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text("vomissement : ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text(data2['vomissement'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text("battements : ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                              Text(data2['battements'], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                                                                                            ],
                                                                                          ),
                                                                                          Container(
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Expanded(flex: 1, child: Container()),
                                                                                                Expanded(
                                                                                                  flex: 4,
                                                                                                  child: ElevatedButton(
                                                                                                      onPressed: () async {
                                                                                                        userReff000.doc(data.id).update({
                                                                                                          "remarques": "normale",
                                                                                                          "symptome": "no"
                                                                                                        });
                                                                                                        userReff000.doc(data.id).collection("symptome").doc(data2.id).delete();
                                                                                                        await http.post(
                                                                                                          Uri.parse('https://fcm.googleapis.com/fcm/send'),
                                                                                                          headers: <String, String>{
                                                                                                            'Content-Type': 'application/json ; charset=UTF-8',
                                                                                                            'Authorization': 'key=AAAA7AAFiK8:APA91bElHqaLN-U0ce4pl4kpvLfDZs5sO9mXw0EGOAmAq2ljv7vimKRQb4jT2z3E77PeuFFrjXprOngX8lHIegiWxOeZiTPBG6AxhaSFrNwOFVjzH3vxtU4PzIdJ0f0gNDYCkv8pWe7b',
                                                                                                          },
                                                                                                          body: jsonEncode(
                                                                                                            <String, dynamic>{
                                                                                                              'notification': <String, dynamic>{
                                                                                                                'body': 'votre cas est normale',
                                                                                                                'title': "symptome"
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
                                                                                                            builder: (context) => lisepatientsymptomes(),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                      child: Text("normale"),
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
                                                                                                                          userReff000.doc(data.id).collection("consultationapres").add({
                                                                                                                            "jour": jour1,
                                                                                                                            "moins": moins1,
                                                                                                                            "année": annee1,
                                                                                                                            "heure": heure1,
                                                                                                                            "salle": salle1,
                                                                                                                          });
                                                                                                                          userReff000.doc(data.id).update({
                                                                                                                            "symptome": "en attente",
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
                                                                                                                                  'body': 'votre séance de consltation aprés votre chimio',
                                                                                                                                  'title': "symptome"
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
                                                                                                                              builder: (context) => lisepatientsymptomes(),
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
                                                                                                    child: Text("urgent"),
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
                                                                                                        "symptome": "no",
                                                                                                        "remarque": ""
                                                                                                      });
                                                                                                      userReff000.doc(data.id).collection("symptome").doc(data2.id).delete();
                                                                                                      await http.post(
                                                                                                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                                                                                                        headers: <String, String>{
                                                                                                          'Content-Type': 'application/json ; charset=UTF-8',
                                                                                                          'Authorization': 'key=AAAA7AAFiK8:APA91bElHqaLN-U0ce4pl4kpvLfDZs5sO9mXw0EGOAmAq2ljv7vimKRQb4jT2z3E77PeuFFrjXprOngX8lHIegiWxOeZiTPBG6AxhaSFrNwOFVjzH3vxtU4PzIdJ0f0gNDYCkv8pWe7b',
                                                                                                        },
                                                                                                        body: jsonEncode(
                                                                                                          <String, dynamic>{
                                                                                                            'notification': <String, dynamic>{
                                                                                                              'body': 'votre consultation aprés chimio verifier',
                                                                                                              'title': "symptome"
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
                                                                                                          builder: (context) => lisepatientsymptomes(),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                    child: Text("valider"),
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
                                                                          icon:
                                                                              Icon(
                                                                            Icons.arrow_forward_ios,
                                                                            size:
                                                                                20.0,
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
                                                    });
                                              }
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
    );
  }
}
