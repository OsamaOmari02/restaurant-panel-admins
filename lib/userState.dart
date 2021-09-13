

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/drinks_admin.dart';
import 'package:restaurants_panel/provider.dart';
import 'package:restaurants_panel/res_admin.dart';
import 'package:restaurants_panel/shawarma_admin.dart';
import 'package:restaurants_panel/sweet_admin.dart';

import 'homos_admin.dart';
import 'languageProvider.dart';
import 'logIn.dart';

class UserState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Login();
          } else if (snapshot.hasData) {
            if (provider.authData['type']!.trim()=="shawarma")
              return AdminShawarma();
            else if (provider.authData['type']!.trim()=="homos")
              return AdminHomos();
            else if (provider.authData['type']!.trim()=="sweet")
              return AdminSweets();
            else if (provider.authData['type']!.trim()=="mainRes")
              return AdminRes();
            else if (provider.authData['type']!.trim()=="drinks")
              return AdminDrinks();
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
