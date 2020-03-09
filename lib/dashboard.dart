import 'package:attendance/login.dart';
import 'package:attendance/main.dart';
import 'package:attendance/singup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Material MyItems(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                //Icon
                Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    )),
              ],
            )
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Center(
            child: Text('Dashbo')),
            actions: <Widget>[
          FlatButton(
            child: Text("Log Out"),
            textColor: Colors.white,
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((result) =>
                     Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => Login()))
                     .catchError((err) => print(err)));
            },
          )
        ],

        ),
        body: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              MyItems(Icons.graphic_eq, "Totalviews", 0xffed622b),
              MyItems(Icons.graphic_eq, "Totalviews", 0xffed622b),
              MyItems(Icons.graphic_eq, "Totalviews", 0xffed622b),
              MyItems(Icons.graphic_eq, "Totalviews", 0xffed622b),
              MyItems(Icons.graphic_eq, "Totalviews", 0xffed622b),
              MyItems(Icons.graphic_eq, "Ayush", 0xffed622b),
              // MyItems(Icons.graphic_eq, "Ayush", 0xffed622b),
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 130.0),
              StaggeredTile.extent(1, 250.0),
              StaggeredTile.extent(1, 120.0),
              StaggeredTile.extent(1, 120.0),
              StaggeredTile.extent(2, 130.0),
              //StaggeredTile.extent(2, 110.0),
              //StaggeredTile.extent(2, 130.0)
              //StaggeredTile.extent(2, 230.0)
            ]));
  }
}
