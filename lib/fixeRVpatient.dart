import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilepatient.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';

class fixeRV extends StatefulWidget {
  @override
  State<fixeRV> createState() => _MyWidgetState();
}

CollectionReference userReff0 =
    FirebaseFirestore.instance.collection("patient");

class _MyWidgetState extends State<fixeRV> {
  String imageurl = 'no';
  CollectionReference image = FirebaseFirestore.instance.collection("patient");
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
          'Date De Consultation ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100, left: 5, right: 5),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Prendre un rendez vous ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900)),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 35),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Divider(
                                            thickness: 0.8,
                                            color: Colors.grey[400],
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'Pour le dépôt du dossier médécal',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
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

                                    //start

                                    //end
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Divider(
                                            thickness: 0.8,
                                            color: Colors.grey[400],
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'Obligatoire',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
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

                                    //start

                                    //end
                                  ],
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.document_scanner,
                                    color: Colors.red[800],
                                  ),
                                  title: Text(
                                    'Analyse',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      if (data['analyse1'] == "no") {
                                        ImagePicker imagePicker = ImagePicker();
                                        XFile? file =
                                            await imagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        if (file == null) return;
                                        String uniquefilename = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();
                                        Reference referenceROOt =
                                            FirebaseStorage.instance.ref();
                                        Reference referencedirimages =
                                            referenceROOt.child('imageanalyse');
                                        Reference referenceimageupload =
                                            referencedirimages
                                                .child(uniquefilename);
                                        try {
                                          await referenceimageupload
                                              .putFile(File(file.path));
                                          imageurl = await referenceimageupload
                                              .getDownloadURL();
                                        } catch (error) {}
                                        setState(() {
                                          userReff0
                                              .doc(data.id)
                                              .update({"analyse1": imageurl});
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.upload_file,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (data["analyse1"] != "no")
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Container(
                                              child: Image.network(
                                                "${data['analyse1']}",
                                                fit: BoxFit.contain,
                                                height: 300,
                                              ),
                                            ),
                                          );
                                        });
                                },
                                child: Text("analyse"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shadowColor: Colors.red,
                                ),
                              ),
                              Text("  "),
                              ElevatedButton(
                                onPressed: () {
                                  if (data['demande'] == 'nodemande' &&
                                      data['analyse1'] != "no") {
                                    print(imageurl);
                                    image.doc(data.id).update({"remarque": ""});
                                    userReff0
                                        .doc(data.id)
                                        .update({"demande": "demande"});
                                  } else if (data["analyse1"] == "no") {
                                    AwesomeDialog(
                                      context: context,
                                      title: "Warning",
                                      desc: "prendre photo en premier",
                                      dialogType: DialogType.warning,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                    ).show();
                                  }
                                  if (data["demande"] == "demande") {
                                    AwesomeDialog(
                                      context: context,
                                      title: "Warning",
                                      desc: "en attende de réponse",
                                      dialogType: DialogType.success,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                    ).show();
                                  }
                                },
                                child: Icon(Icons.add),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shadowColor: Colors.red,
                                    elevation: 10),
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
    );
  }
}
