import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/drawer.dart';
import 'package:restaurants_panel/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'languageProvider.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  var stream;
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).detailedCart.clear();
    stream = FirebaseFirestore.instance
        .collection(
        'restaurants orders/${Provider.of<MyProvider>(context, listen: false)
            .authData['name']}/orders')
        .orderBy('date', descending: true)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    dialog2() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () async =>
                        await launch('tel://0779434462'),
                        child: const Text(
                          "0779434462",
                          style: const TextStyle(fontSize: 18),
                        )),
                    TextButton(
                        onPressed: () async =>
                        await launch('tel://0795143290'),
                        child: const Text(
                          "0795143290",
                          style: const TextStyle(fontSize: 18),
                        )),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              actions: [
                TextButton(
                    child: Text(lanProvider.texts('cancel?'),
                        style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(lanProvider.texts('orders')),
          backgroundColor: Colors.orangeAccent,
          actions: [
            IconButton(onPressed: () => dialog2(), icon: const Icon(Icons.call)),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState==ConnectionState.waiting)
              return const Center(child: const CircularProgressIndicator());
            if (snapshot.hasError)
               Center(child: Text(lanProvider.texts('Error occurred !')));
            return Scrollbar(
                child: ListView.builder(
                    itemCount: snapshot.data?.docs.length??0,
                    itemBuilder: (context, int index) {
                      var resData = snapshot.data!.docs;
                      return Card(
                        elevation: 3.5,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    provider.details['name'] =
                                        resData[index]['name'];
                                    provider.details['total'] =
                                        resData[index]['total'].toString();
                                    provider.details['note'] =
                                        resData[index]['note'];
                                    provider.details['length'] =
                                        resData[index]['length'].toString();
                                    for (int i = 0;
                                        i < int.parse(resData[index]['length']);
                                        i++)
                                      provider.detailedCart.add(FoodCart(
                                          mealName: resData[index]['meals'][i]
                                              ['meal name'],
                                          mealPrice: resData[index]['meals'][i]
                                              ['meal price'],
                                          quantity: resData[index]['meals'][i]
                                              ['quantity'],
                                          description: resData[index]['meals']
                                              [i]['description']));
                                  });
                                  Navigator.of(context)
                                      .pushReplacementNamed('details');
                                },
                                trailing: Checkbox(
                                  value: resData[index]['isChecked'],
                                  onChanged: (bool? value) async {
                                    await FirebaseFirestore.instance
                                        .collection('restaurants orders/${provider.authData['name']}/orders')
                                        .doc(resData[index].id)
                                        .update({
                                      'isChecked': value,
                                    });
                                  },
                                  checkColor: Colors.white,
                                  activeColor: Colors.green,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.0),
                                  child: Text(resData[index]['name']),
                                ),
                                subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(provider
                                        .dateTime(resData[index]['date']))),
                              ),
                            ),
                          ],
                        ),
                      );
                    }));
          },
        ),
      ),
    );
  }
}
