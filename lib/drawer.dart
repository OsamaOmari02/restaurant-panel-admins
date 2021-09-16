import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/provider.dart';

import 'languageProvider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);

    Widget listTile(String title, icon, route) {
      return ListTile(
        onTap: () => Navigator.of(context).pushReplacementNamed(route),
        title: Text(
          title,
          style: const TextStyle(fontSize: 25),
        ),
        leading: Icon(
          icon,
          color: Colors.blueAccent,
        ),
      );
    }

    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: lanProvider.isEn ? TextAlign.start : TextAlign.end,
                style: const TextStyle(fontSize: 23),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                const SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('ok'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    logOutFun() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                lanProvider.texts('log out?'),
                textAlign: lanProvider.isEn ? TextAlign.start : TextAlign.end,
                style: const TextStyle(fontSize: 23),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                InkWell(
                    child: Text(
                      lanProvider.texts('yes?'),
                      style: const TextStyle(fontSize: 19, color: Colors.red),
                    ),
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          provider.authState = authStatus.Authenticated;
                          Navigator.of(context).pushReplacementNamed('login');
                          Provider.of<MyProvider>(context, listen: false)
                              .authData
                              .clear();
                          Provider.of<MyProvider>(context, listen: false)
                              .mealIDs
                              .clear();
                        });
                      } on FirebaseException catch (e) {
                        dialog(e.message);
                        setState(() {
                          provider.authState = authStatus.unAuthenticated;
                        });
                      } catch (e) {
                        dialog(lanProvider.texts('Error occurred !'));
                        print(e);
                        setState(() {
                          provider.authState = authStatus.unAuthenticated;
                        });
                      }
                    }),
                const SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('cancel?'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            ListTile(
              onTap: () {
                if (provider.authData['type'] == "shawarma")
                  Navigator.of(context).pushReplacementNamed('adminShawarma');
                else if (provider.authData['type'] == "homos")
                  Navigator.of(context).pushReplacementNamed('adminHomos');
                else if (provider.authData['type'] == "drinks")
                  Navigator.of(context).pushReplacementNamed('adminDrinks');
                else if (provider.authData['type'] == "mainRes")
                  Navigator.of(context).pushReplacementNamed('adminRes');
                else if (provider.authData['type'] == "sweet")
                  Navigator.of(context).pushReplacementNamed('adminSweets');
              },
              title: Text(
                lanProvider.texts('Drawer1'),
                style: const TextStyle(fontSize: 25),
              ),
              leading: Icon(
                Icons.home,
                color: Colors.blueAccent,
              ),
            ),
            const Divider(
              thickness: 0.1,
            ),
            listTile(lanProvider.texts('Drawer6'), Icons.settings, 'settings'),
            const Divider(thickness: 0.1),
            ListTile(
              onTap: logOutFun,
              title: Text(
                lanProvider.texts('Drawer8'),
                style: const TextStyle(fontSize: 25, color: Colors.red),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
