import 'package:flutter/material.dart';
import 'package:memoire00/comptemedecin.dart';
import 'package:memoire00/comptepatient.dart';
import 'package:memoire00/comptesecretaire.dart';
import 'package:memoire00/main.dart';
import 'package:memoire00/profilemedecin.dart';
import 'package:memoire00/profilepatient.dart';
import 'package:memoire00/profilesecretaire.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 100),
              child: InkWell(
                child: Image.asset("images/doctor.png"),
                onTap: () async {
                  if (islogin == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => comptepatient(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profile_patient(),
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              child: InkWell(
                child: Image.asset("images/patient.png"),
                onTap: () async {
                  if (islogin == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => comptemedecin(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilemedecin(),
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
              child: InkWell(
                child: Image.asset("images/admin.png"),
                onTap: () async {
                  if (islogin == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => comptesecretaire(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profile_secretaire(),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
