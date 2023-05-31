import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/comptesecretaire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class formulairesecretaire extends StatefulWidget {
  const formulairesecretaire({super.key});

  @override
  State<formulairesecretaire> createState() => _formulairesecretaireState();
}

class _formulairesecretaireState extends State<formulairesecretaire> {
  // les méthodes///////////////////////////////////////////////
  signup() async {
    var fromdata = fromstate.currentState;
    if (fromdata!.validate()) {
      fromdata.save();
      try {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
            context: context,
            title: "Warning",
            desc: "mot de passe court",
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            showCloseIcon: true,
          ).show();
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
            context: context,
            title: "Warning",
            desc: "email déja existe",
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            showCloseIcon: true,
          ).show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("notvalidat");
    }
  }

  adddata() async {
    CollectionReference userReff =
        FirebaseFirestore.instance.collection("secretaire");
    userReff.add({
      "nom": nom,
      "prenon": prenom,
      "email": email,
      "userid": FirebaseAuth.instance.currentUser!.uid,
      "phone": phone,
    });
  }

  RegExp regExp1 =
      new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@stabibi.com");
  RegExp regExp2 = new RegExp(r'^.{8,}$');
  RegExp regExp3 = new RegExp(r'^0(5|6|7)[0-9]{8}$');

  ////////////////////////////////////////////////
  GlobalKey<FormState> fromstate = new GlobalKey();

  ///////////////////////////////////////////////////////////////////////
  var selectm;
  //basededonnés//////////////////////////////////////////////////////////////////

  //true/////////////////////////////////////////////////////////////////////
  String email = "";
  String password = "";
  String nom = "";
  String prenom = "";
  String cnfmotdepass = "";
  String phone = "";
  String jour = "";
  String moins = "";
  String annees = "";
  String genre = "";
  //false///////////////////////////////////////////////////////////////////////////
  String namef = "";
  String prenomf = "";
  String emailf = "";
  String motdepassef = "";
  String confmotdepassef = "";
  String phonef = "";
  String jourf = "";
  String moinsf = "";
  String anneesf = "";
  String Genref = "";
/////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulaire de admin"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => comptesecretaire(),
              ),
            );
          },
        ),
        elevation: 5,
        backgroundColor: Colors.red,
        shadowColor: Colors.red,
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Form(
                key: fromstate,
                child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Center(
                        child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: EdgeInsets.only(left: 5),
                              width: 150,
                              child: TextFormField(
                                onSaved: (val) {
                                  nom = val!;
                                },
                                validator: (val) {
                                  if ((val!.length > 12) || (val.length < 2)) {
                                    return "langeur invalide";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                cursorColor: Colors.red,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(114, 0, 0, 0),
                                            width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(114, 0, 0, 0),
                                            width: 2)),
                                    filled: true,
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(93, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    labelText: "Nom",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              width: 150,
                              child: TextFormField(
                                onSaved: (val) {
                                  prenom = val!;
                                },
                                validator: (val) {
                                  if ((val!.length > 12) || (val.length < 2)) {
                                    return "langeur invalide";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                cursorColor: Colors.red,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(114, 0, 0, 0),
                                            width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(114, 0, 0, 0),
                                            width: 2)),
                                    filled: true,
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(93, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    labelText: "Prénom",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                "$namef",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 52, 54, 55),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "$prenomf",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 52, 54, 55),
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, left: 5, right: 5),
                        child: TextFormField(
                          onSaved: (val) {
                            email = val!;
                          },
                          validator: (val) {
                            if (!regExp1.hasMatch(val!)) {
                              return "invalide";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(114, 0, 0, 0),
                                      width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(114, 0, 0, 0),
                                      width: 2)),
                              filled: true,
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(93, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              labelText: "Email",
                              hintText: "example@stabibi.com",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.red,
                              )),
                        ),
                      ),
                      Container(
                        child: Text(
                          "$emailf",
                          style: TextStyle(
                            color: Color.fromARGB(255, 52, 54, 55),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                        child: TextFormField(
                          onSaved: (val) {
                            password = val!.trim().toLowerCase();
                          },
                          validator: (val) {
                            if (!regExp2.hasMatch(val!)) {
                              return "invalide";
                            }
                            return null;
                          },
                          obscureText: true,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(114, 0, 0, 0),
                                      width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(114, 0, 0, 0),
                                      width: 2)),
                              filled: true,
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(93, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              labelText: "Mot de passe",
                              hintText: "Doit comporter au moins 8 caractères",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.red,
                              )),
                        ),
                      ),
                      Container(
                        child: Text(
                          "$motdepassef",
                          style: TextStyle(
                            color: Color.fromARGB(255, 52, 54, 55),
                            fontSize: 12,
                          ),
                        ),
                      ),

                      Container(
                        child: Text(
                          "$confmotdepassef",
                          style: TextStyle(
                            color: Color.fromARGB(255, 52, 54, 55),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                        child: TextFormField(
                          onSaved: (val) {
                            phone = val!;
                          },
                          validator: (val) {
                            if (!regExp3.hasMatch(val!)) {
                              return "invalide";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(114, 0, 0, 0),
                                      width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(114, 0, 0, 0),
                                      width: 2)),
                              filled: true,
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(93, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              labelText: "phone",
                              hintText: "0000 00 00 00",
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.red,
                              )),
                        ),
                      ),
                      Container(
                        child: Text(
                          "$phonef",
                          style: TextStyle(
                            color: Color.fromARGB(255, 52, 54, 55),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      //anniversaire.................................................
                    ]))),
              ),
              Container(
                  width: 350,
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: (() async {
                      var response = await signup();
                      if (response != null) {
                        await adddata();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => comptesecretaire(),
                          ),
                        );
                      } else {
                        print("sign in failed");
                      }
                    }),
                    child: Text("s'incrire"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shadowColor: Colors.red,
                        elevation: 10),
                  )),
            ],
          )),
    );
  }
}
