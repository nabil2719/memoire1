import 'package:firebase_auth/firebase_auth.dart';
import 'package:memoire00/comptepatient.dart';
import 'package:memoire00/comptesecretaire.dart';
import 'package:memoire00/documentpatient.dart';
import 'package:memoire00/fixeRVpatient.dart';

import 'package:memoire00/formulairemedecin.dart';
import 'package:memoire00/formulairepatient.dart';
import 'package:memoire00/formulairesecretaire.dart';
import 'package:memoire00/consulesymptome.dart';
import 'package:memoire00/historiqueRV.dart';
import 'package:memoire00/homepage.dart';
import 'package:memoire00/infomedecin.dart';
import 'package:memoire00/infopatient.dart';
import 'package:memoire00/infosecretaire.dart';
import 'package:memoire00/infossurvotremedecin.dart';
import 'package:memoire00/listemedecin.dart';
import 'package:memoire00/listepatient.dart';
import 'package:memoire00/listepatientdemandeRV.dart';
import 'package:memoire00/profilemedecin.dart';
import 'package:memoire00/profilepatient.dart';
import 'package:memoire00/profilesecretaire.dart';
import 'package:memoire00/signup.dart';
import 'package:memoire00/comptemedecin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memoire00/symptome.dart';
import 'package:memoire00/traitement.dart';

var islogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }

  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage(),
      routes: {
        "signup": (context) => signup(),
        "comptepatient": (context) => comptepatient(),
        "formulaire": (context) => formulairepatient(),
        "Profile_patient": (context) => profile_patient(),
        "comptemedecin": (context) => comptemedecin(),
        "formulairemedecin": (context) => formulairemedecin(),
        "historiqueRV": (context) => historiqueRV(),
        "fixeRV": (context) => fixeRV(),
        "profilemedecin": (context) => profilemedecin(),
        "comptesecretaire": (context) => comptesecretaire(),
        "profilesecretaire": (context) => profile_secretaire(),
        "formulairesecretaire": (context) => formulairesecretaire(),
        "infopatient": (context) => infopatient(),
        "infosecretaire": (context) => infosecretaire(),
        "infomedecin": (context) => infomedecin(),
        "infosurvotremedecin": (context) => infosurvotrmedecin(),
        "traitement": (context) => traitement(),
        "consulesymptome": (context) => consulesymptome(),
        "listepatient": (context) => listepatient(),
        "symptome": (context) => symptome(),
        "listemédecin": (context) => listemedecin(),
        "listepatientdemandeRV": (context) => listepatientdemandeRV(),
        "documentpatient": (context) => documentpatient(),
      },
    );
  }
}
