import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/formulairepatient.dart';
import 'package:memoire00/profilepatient.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class comptepatient extends StatefulWidget {
  const comptepatient({super.key});

  @override
  State<comptepatient> createState() => _comptepatientState();
}

class _comptepatientState extends State<comptepatient> {
  GlobalKey<FormState> fromstate = new GlobalKey();

  signIn() async {
    var fromdata = fromstate.currentState;
    if (fromdata!.validate()) {
      fromdata.save();

      try {
        UserCredential user1 =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return user1;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
            context: context,
            title: "Warning",
            desc: "email éxiste pas",
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            showCloseIcon: true,
          ).show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            context: context,
            title: "Warning",
            desc: "mot de passe faux",
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            showCloseIcon: true,
          ).show();
        }
      }
    }
  }

  late UserCredential user1;

  //var email

  String email = "";
  //var mot de passe
  String password = "";

  //expression regulier email

  RegExp regExp1 =
      new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@ptabibi.com");
  //expression regulier mot de passe

  RegExp regExp2 = new RegExp(r'^.{8,}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            padding: EdgeInsets.only(bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Form(
                  key: fromstate,
                  child: Column(
                    children: [
                      //logo****************
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 130),
                          child: Image.asset("images/loginp.png",
                              width: 100, height: 100, fit: BoxFit.fill),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "S'inscrire",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      //adresse email **************
                      Center(
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 15, left: 10, right: 10),
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
                                hintText: "example@ptabibi.com",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.red,
                                )),
                          ),
                        ),
                      ),
                      //mot de passe*****************
                      Center(
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
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
                                hintText:
                                    "Doit comporter au moins 8 caractères",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.red,
                                )),
                          ),
                        ),
                      ),
                      Container(
                          width: 350,
                          padding: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () async {
                              var sign = await signIn();
                              if (sign != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => profile_patient(),
                                  ),
                                );
                              }
                            },
                            child: Text("suivi"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shadowColor: Colors.red,
                                elevation: 10),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "N'a pas de compte?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(171, 0, 0, 0)),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => formulairepatient(),
                                ),
                              );
                            },
                            child: Text(
                              "S'inscrire",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(226, 244, 67, 54)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
