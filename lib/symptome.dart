import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class symptome extends StatefulWidget {
  const symptome({super.key});

  @override
  State<symptome> createState() => _symptomeState();
}

class _symptomeState extends State<symptome> {
  var symptomeGroupfatigue;
  var symptomeGroupvomissement;
  var symptomeGroupbattementsdecoeur;
  var valslider = 38.0;
  var valu;
  var valperte = 0.0;
  var symptomeGroupessouflement;

  CollectionReference userRefs =
      FirebaseFirestore.instance.collection("patient");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20.0,
            ),
            color: Colors.white,
          ),
          title: Text(
            'Analyser mes symptômes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Container(
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
                      return Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: [
                            ...List.generate(
                              1,
                              (index) => Container(
                                margin: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0, 0, 0),
                                      child: Text(
                                        'Fatigue :',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '  Faible',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            Radio(
                                                activeColor: Colors.green,
                                                value: "faible",
                                                groupValue:
                                                    symptomeGroupfatigue,
                                                onChanged: (faible) {
                                                  setState(() {
                                                    symptomeGroupfatigue =
                                                        faible;
                                                  });
                                                })
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '   Moyen',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            Radio(
                                                activeColor: Colors.green,
                                                value: "moyen",
                                                groupValue:
                                                    symptomeGroupfatigue,
                                                onChanged: (moyen) {
                                                  setState(() {
                                                    symptomeGroupfatigue =
                                                        moyen;
                                                  });
                                                })
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Élève',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            Radio(
                                                activeColor: Colors.green,
                                                value: "eleve",
                                                groupValue:
                                                    symptomeGroupfatigue,
                                                onChanged: (eleve) {
                                                  setState(() {
                                                    symptomeGroupfatigue =
                                                        eleve;
                                                  });
                                                })
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                height: 150.0,
                                width: 400.0,
                                color: Colors.grey[400],
                              ),
                            ),
                            ...List.generate(
                              1,
                              (index) => Container(
                                margin: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0, 0, 0),
                                      child: Text(
                                        'Vomissements :',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.0,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '<= 1',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            Radio(
                                                activeColor: Colors.green,
                                                value: "faibleee",
                                                groupValue:
                                                    symptomeGroupvomissement,
                                                onChanged: (faibleee) {
                                                  setState(() {
                                                    symptomeGroupvomissement =
                                                        faibleee;
                                                  });
                                                })
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '          <= 1 && >= 4',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            Radio(
                                                activeColor: Colors.green,
                                                value: "moyennn",
                                                groupValue:
                                                    symptomeGroupvomissement,
                                                onChanged: (moyennn) {
                                                  setState(() {
                                                    symptomeGroupvomissement =
                                                        moyennn;
                                                  });
                                                })
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '>= 4',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            Radio(
                                                activeColor: Colors.green,
                                                value: "eleveee",
                                                groupValue:
                                                    symptomeGroupvomissement,
                                                onChanged: (eleveee) {
                                                  setState(() {
                                                    symptomeGroupvomissement =
                                                        eleveee;
                                                  });
                                                })
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                height: 150.0,
                                width: 400.0,
                                color: Colors.grey[300],
                              ),
                            ),
                            ...List.generate(
                              1,
                              (index) => Container(
                                margin: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0, 0, 0),
                                      child: Text(
                                        'Battements de coeur :',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 20.0, 0, 0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Oui',
                                                style:
                                                    TextStyle(fontSize: 15.0),
                                              ),
                                              Radio(
                                                  activeColor: Colors.green,
                                                  value: "oui",
                                                  groupValue:
                                                      symptomeGroupbattementsdecoeur,
                                                  onChanged: (oui) {
                                                    setState(() {
                                                      symptomeGroupbattementsdecoeur =
                                                          oui;
                                                    });
                                                  })
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Non',
                                                style:
                                                    TextStyle(fontSize: 15.0),
                                              ),
                                              Radio(
                                                  activeColor: Colors.green,
                                                  value: "non",
                                                  groupValue:
                                                      symptomeGroupbattementsdecoeur,
                                                  onChanged: (non) {
                                                    setState(() {
                                                      symptomeGroupbattementsdecoeur =
                                                          non;
                                                    });
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                height: 150.0,
                                width: 400.0,
                                color: Colors.grey[400],
                              ),
                            ),
                            ...List.generate(
                              1,
                              (index) => Container(
                                margin: EdgeInsets.all(10.0),
                                // ignore: sort_child_properties_last
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0, 0, 0),
                                      child: Text(
                                        'Fièvre :',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Slider(
                                        label: "$valslider",
                                        divisions: 6,
                                        activeColor: Colors.green,
                                        min: 36.0,
                                        max: 42.0,
                                        value: valslider,
                                        onChanged: (valu) {
                                          setState(() {
                                            valslider = valu;
                                          });
                                        }),
                                  ],
                                ),
                                height: 150.0,
                                width: 400.0,
                                color: Colors.grey[300],
                              ),
                            ),
                            ...List.generate(
                              1,
                              (index) => Container(
                                margin: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0, 0, 0),
                                      child: Text(
                                        'Perte de poids :',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Slider(
                                        label: "$valperte",
                                        divisions: 10,
                                        activeColor: Colors.green,
                                        min: 0.0,
                                        max: 5.0,
                                        value: valperte,
                                        onChanged: (valuperte) {
                                          setState(() {
                                            valperte = valuperte;
                                          });
                                        })
                                  ],
                                ),
                                height: 150.0,
                                width: 400.0,
                                color: Colors.grey[400],
                              ),
                            ),
                            Container(
                                width: 350,
                                padding: EdgeInsets.only(
                                    top: 20, right: 40, left: 40),
                                child: ElevatedButton(
                                  onPressed: (() async {
                                    print(data['symptome']);
                                    if (data['symptome'] == "no" &&
                                        data['chimio'] == "prochaine") {
                                      var fatigue1 =
                                          symptomeGroupfatigue.toString();
                                      var battements1 =
                                          symptomeGroupbattementsdecoeur
                                              .toString();
                                      var fievre1 = valslider.toString();
                                      var pertepoid1 = valperte.toString();
                                      var vomissement1 =
                                          symptomeGroupvomissement.toString();

                                      await userRefs
                                          .doc(data.id)
                                          .collection('symptome')
                                          .add({
                                        "fatigue": fatigue1,
                                        "battements": battements1,
                                        "fiévre": fievre1,
                                        "pertepoid": pertepoid1,
                                        "vomissement": vomissement1,
                                        "symptome": "yes",
                                        "remarque": ""
                                      });
                                      userRefs
                                          .doc(data.id)
                                          .update({'symptome': 'yes'});
                                    }
                                    if (data["symptome"] == "yes") {
                                      AwesomeDialog(
                                        context: context,
                                        title: "Vous avez défini vos symptômes",
                                        desc: "Attendre la réponse du médecin",
                                        dialogType: DialogType.warning,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                      ).show();
                                    } else if (data["chimio"] ==
                                            "no verifier" ||
                                        (data["chimio1"] == "ok")) {
                                      AwesomeDialog(
                                        context: context,
                                        title: "chimiothérapie",
                                        desc:
                                            "Il peut être envoyé après la chimiothérapie",
                                        dialogType: DialogType.warning,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                      ).show();
                                    }
                                  }),
                                  child: Text("Envoyer"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shadowColor: Colors.red,
                                      elevation: 10),
                                )),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return CircularProgressIndicator();
              }),
        ));
  }
}
