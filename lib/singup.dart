import 'package:attendance/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String name, email, mobile;
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
            margin: new EdgeInsets.all(35.0),
            child: new Form(child: FormUI(context)),
          ),
        ),
      ),
    );
  }
}

String name, email, mobile;
Widget FormUI(BuildContext context) {
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  TextEditingController enrollmentController = new TextEditingController();
  TextEditingController semController = new TextEditingController();
  TextEditingController branchController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();

  firstNameInputController = new TextEditingController();
  lastNameInputController = new TextEditingController();
  emailInputController = new TextEditingController();
  pwdInputController = new TextEditingController();
  confirmPwdInputController = new TextEditingController();
  return new Column(
    children: <Widget>[
      new TextFormField(
        controller: firstNameInputController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'First Name',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        maxLength: 20,
        validator: validateName,
        onSaved: (String val) {
          name = val;
        },
      ),
      new TextFormField(
        controller: lastNameInputController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Last Name',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new TextFormField(
        controller: enrollmentController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Enrollment Number',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new TextFormField(
        controller: semController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Sem',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new TextFormField(
        controller: branchController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Branch',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new TextFormField(
        controller: genderController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Gender',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new TextFormField(
        controller: emailInputController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Email',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new TextFormField(
        controller: pwdInputController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new TextFormField(
        controller: confirmPwdInputController,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Conform Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
      new RaisedButton(
          child: new Text(
            "Singup",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            if (1 == 1) {
              if (pwdInputController.text == confirmPwdInputController.text) {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: emailInputController.text,
                        password: pwdInputController.text)
                    .then((currentUser) => Firestore.instance
                        .collection("users")
                        .document(currentUser.uid)
                        .setData({
                          "uid": currentUser.uid,
                          "fname": firstNameInputController.text,
                          "surname": lastNameInputController.text,
                          "email": emailInputController.text,
                          "enrollment": enrollmentController.text,
                          "sem": semController.text,
                          "branch": branchController.text,
                          "gender": genderController.text,
                          "value": "Student",
                        })
                        .then((result) => {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Dashboard())),
                              firstNameInputController.clear(),
                              lastNameInputController.clear(),
                              emailInputController.clear(),
                              pwdInputController.clear(),
                              confirmPwdInputController.clear()
                            })
                        .catchError((err) => print(err)))
                    .catchError((err) => print(err));
              }
            }
          }),
      new RaisedButton(
          child: new Text(
            "Login",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Login()));
          })
    ],
  );
}

String validateName(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}
