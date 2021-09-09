
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/provider.dart';

import 'LanguageProvider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  ListTile listTile(String title, icon, route, BuildContext ctx) {
    return ListTile(
      onTap: () => Navigator.of(ctx).pushReplacementNamed(route),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
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
                    onTap: () async{
                      try {
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          provider.authState = authStatus.Authenticated;
                          Navigator.of(context).pushReplacementNamed('login');
                          Provider.of<MyProvider>(context,listen: false).authData.clear();
                          Provider.of<MyProvider>(context,listen: false).mealIDs.clear();
                        });
                      } on FirebaseException catch (e){
                        dialog(e.message);
                        setState(() {
                          provider.authState = authStatus.unAuthenticated;
                        });
                      } catch (e){
                        dialog(lanProvider.texts('Error occurred !'));
                        print(e);
                        setState(() {
                          provider.authState = authStatus.unAuthenticated;
                        });
                      }
                    }
                ),
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
            listTile(lanProvider.texts('Drawer1'), Icons.home, 'admin',
                context),
            const Divider(thickness: 0.1,),
            listTile(lanProvider.texts('Drawer6'), Icons.settings, 'settings',
                context),
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
