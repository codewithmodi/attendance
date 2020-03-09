import 'package:attendance/main.dart';
import 'package:attendance/singup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: Center(
          child: Text('Login'),
        ),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(45.0),
          child: new Form(child: FormUI(context)),
        ),
      ),
    ));
  }
}

Widget FormUI(BuildContext context) {
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  emailInputController = new TextEditingController();
  pwdInputController = new TextEditingController();
  return new Column(
    children: <Widget>[
      new TextFormField(
        controller: emailInputController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
            hintText: 'Email Address',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new SizedBox(height: 15),
      new TextFormField(
        obscureText: true,
        controller: pwdInputController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
            hintText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new SizedBox(height: 15),
      new RaisedButton(
        child: new Text(
          "Login",
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailInputController.text,
                  password: pwdInputController.text)
              .then((currentUser) => Firestore.instance
                  .collection("users")
                  .document(currentUser.uid)
                  .get()
                  .then((DocumentSnapshot result) => Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => Dashboard()))));
        },
      ),
      new SizedBox(height: 15),
      new RaisedButton(
        child: new Text(
          "Signup",
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Signup()));
        },
      )
    ],
  );
}
