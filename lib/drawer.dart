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
                          Provider.of<MyProvider>(context, listen: false)
                              .authState = authStatus.Authenticated;
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
                          Provider.of<MyProvider>(context, listen: false)
                              .authState = authStatus.unAuthenticated;
                        });
                      } catch (e) {
                        dialog(lanProvider.texts('Error occurred !'));
                        print(e);
                        setState(() {
                          Provider.of<MyProvider>(context, listen: false)
                              .authState = authStatus.unAuthenticated;
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
            listTile(lanProvider.texts('Drawer1'), Icons.home, 'orders'),
            const Divider(thickness: 0.3),
            ListTile(
              onTap: () {
                if (Provider.of<MyProvider>(context, listen: false)
                        .authData['type'] == "shawarma")
                  Navigator.of(context).pushReplacementNamed('adminShawarma');
                else if (Provider.of<MyProvider>(context, listen: false)
                        .authData['type'] == "drinks")
                  Navigator.of(context).pushReplacementNamed('adminDrinks');
                else if (Provider.of<MyProvider>(context, listen: false)
                        .authData['type'] == "mainRes")
                  Navigator.of(context).pushReplacementNamed('adminRes');
                else if (Provider.of<MyProvider>(context, listen: false)
                        .authData['type'] == "sweet")
                  Navigator.of(context).pushReplacementNamed('adminSweets');
                else if (Provider.of<MyProvider>(context, listen: false)
                        .authData['type'] == "pizza")
                  Navigator.of(context).pushReplacementNamed('adminPizza');
                else if (Provider.of<MyProvider>(context, listen: false)
                        .authData['type'] == "rice")
                  Navigator.of(context).pushReplacementNamed('adminRice');
                else if (Provider.of<MyProvider>(context, listen: false)
                        .authData['type'] == "mo3ajanat")
                  Navigator.of(context).pushReplacementNamed('adminMo3ajanat');
                else if (Provider.of<MyProvider>(context, listen: false)
                        .authData['type'] == "2drinks")
                  Navigator.of(context).pushReplacementNamed('admin2Drinks');
                // else if (Provider.of<MyProvider>(context,listen: false).authData['type'] == "mo3ajanat")
                //   Navigator.of(context).pushReplacementNamed('adminMo3ajanat');
              },
              title: Provider.of<MyProvider>(context, listen: false)
                              .authData['type'] ==
                          'drinks' ||
                      Provider.of<MyProvider>(context, listen: false)
                              .authData['type'] ==
                          '2drinks'
                  ? Text(
                      lanProvider.texts('Drawer10'),
                      style: const TextStyle(fontSize: 25),
                    )
                  : Text(
                      lanProvider.texts('Drawer9'),
                      style: const TextStyle(fontSize: 25),
                    ),
              leading: Icon(
                Icons.edit_off,
                color: Colors.blueAccent,
              ),
            ),
            const Divider(
              thickness: 0.3,
            ),
            listTile(lanProvider.texts('Drawer6'), Icons.settings, 'settings'),
            const Divider(thickness: 0.3),
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
