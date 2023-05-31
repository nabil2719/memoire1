import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/profilepatient.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';

class documentpatient extends StatefulWidget {
  @override
  State<documentpatient> createState() => _MyWidgetState();
}

CollectionReference userReff0 =
    FirebaseFirestore.instance.collection("patient");

class _MyWidgetState extends State<documentpatient> {
  String lettreorientation = 'no';
  String anapath = "no";

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
          'Votre document ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 5, right: 5),
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
                              ////////////////////////////////////////////////////////////////////////
                              Card(
                                margin: EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: ElevatedButton(
                                    onPressed: () {
                                      if (data["anapath"] != "no") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  child: Image.network(
                                                    "${data['anapath']}",
                                                    fit: BoxFit.contain,
                                                    height: 300,
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                    },
                                    child: Text("voir"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shadowColor: Colors.red,
                                    ),
                                  ),
                                  title: Text(
                                    'anapath',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      if (data['anapath'] == "no") {
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
                                          anapath = await referenceimageupload
                                              .getDownloadURL();
                                        } catch (error) {}
                                        setState(() {
                                          userReff0
                                              .doc(data.id)
                                              .update({"anapath": anapath});
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
                              SizedBox(
                                height: 20,
                              ),
                              //////////////////////////////////////////////////////////////////////////////////////
                              Card(
                                margin: EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: ElevatedButton(
                                    onPressed: () {
                                      if (data["lettreorientation"] != "no") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  child: Image.network(
                                                    "${data['lettreorientation']}",
                                                    fit: BoxFit.contain,
                                                    height: 300,
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                    },
                                    child: Text("voir"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shadowColor: Colors.red,
                                    ),
                                  ),
                                  title: Text(
                                    'lettre orientation',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      if (data['lettreorientation'] == "no") {
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
                                          lettreorientation =
                                              await referenceimageupload
                                                  .getDownloadURL();
                                        } catch (error) {}
                                        setState(() {
                                          userReff0.doc(data.id).update({
                                            "lettreorientation":
                                                lettreorientation
                                          });
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
                              SizedBox(
                                height: 8.0,
                              ),
                              //////////////////////////////////////////////////////////////////////////////////
                              Text("  "),
                              ElevatedButton(
                                onPressed: () {
                                  if (data['lettreorientation'] != 'no' &&
                                      data['anapath'] != "no" &&
                                      data["inscrit"] == "no") {
                                    print(lettreorientation);
                                    print(anapath);

                                    userReff0
                                        .doc(data.id)
                                        .update({"inscrit": "inscrit"});
                                    AwesomeDialog(
                                      context: context,
                                      title: "success",
                                      desc: "success",
                                      dialogType: DialogType.success,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                    ).show();
                                  }
                                  if (data["anapath"] == "no" &&
                                      data["lettreorientation"] == "no") {
                                    AwesomeDialog(
                                      context: context,
                                      title: "Warning",
                                      desc:
                                          "lettre orientation et anapath vide",
                                      dialogType: DialogType.warning,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                    ).show();
                                  } else {
                                    if (data["anapath"] == "no") {
                                      AwesomeDialog(
                                        context: context,
                                        title: "Warning",
                                        desc: "anapath vide",
                                        dialogType: DialogType.warning,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                      ).show();
                                    }
                                    if (data["lettreorientation"] == "no") {
                                      AwesomeDialog(
                                        context: context,
                                        title: "Warning",
                                        desc: "lettre orientation vide",
                                        dialogType: DialogType.success,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                      ).show();
                                    }
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
