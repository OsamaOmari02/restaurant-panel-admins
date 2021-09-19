import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/provider.dart';

import 'drawer.dart';
import 'languageProvider.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.end,
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lanProvider.texts('details')),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        drawer: MyDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Text(
              provider.details['name']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (int i = 0; i < provider.detailedCart.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(provider.detailedCart[i].mealName),
                    subtitle: Text(provider.detailedCart[i].description +
                        "\n" +
                        lanProvider.texts('meal price : ') +
                        provider.detailedCart[i].mealPrice.toString() + " " +
                        lanProvider.texts('jd') +
                        "\n" +
                        lanProvider.texts('quantity : ') +
                        provider.detailedCart[i].quantity.toString()),
                    isThreeLine: true,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  lanProvider.texts('cart total :'),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  provider.details['total'].toString() + " ",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  lanProvider.texts('jd'),
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                color: Colors.lightGreen,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(lanProvider.texts('notes')),
                      Expanded(child: Text(provider.details['note']!)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
