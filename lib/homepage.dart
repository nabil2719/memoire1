import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'signup.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

var na;

class _homepageState extends State<homepage> {
  var token = FirebaseMessaging.instance;
  var f = FirebaseMessaging.instance;

  gettoken() {
    token.getToken().then((value) {
      na = value;
      print(na);
    });
  }

  void initState() {
    gettoken();
    f.getToken().then((value) {
      print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
      print(value);
      print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    });
    FirebaseMessaging.onMessage.listen((event) {
      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      print("${event.notification!.body}");
      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => signup(),
              ),
            );
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.account_box)),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("images/photo1.png"))),
      ),
    );
  }
}
