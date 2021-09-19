

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/drinks_admin.dart';
import 'package:restaurants_panel/orders.dart';
import 'package:restaurants_panel/provider.dart';
import 'package:restaurants_panel/res_admin.dart';
import 'package:restaurants_panel/shawarma_admin.dart';
import 'package:restaurants_panel/sweet_admin.dart';

import 'homos_admin.dart';
import 'languageProvider.dart';
import 'logIn.dart';

class UserState extends StatefulWidget {

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {

  @override
  void initState() {
    Provider.of<MyProvider>(context,listen: false).fetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Login();
          } else if (snapshot.hasData){
            return Orders();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(lanProvider.texts("Error occurred !"),
                  style: const TextStyle(fontSize: 20, color: Colors.red)),
            );
          }
          return Scaffold(
              body: Center(
                  child: Text(lanProvider.texts("something went wrong !"),
                      style:
                      const TextStyle(fontSize: 23, color: Colors.blue))));
        });
  }
}
