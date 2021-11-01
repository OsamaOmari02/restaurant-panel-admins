import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/drawer.dart';
import 'package:restaurants_panel/provider.dart';
import 'languageProvider.dart';

class AdminRes extends StatefulWidget {
  @override
  _AdminResState createState() => _AdminResState();
}


class _AdminResState extends State<AdminRes> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context,listen: false).fetch();
      Provider.of<MyProvider>(context, listen: false).fetchMealsMain(
          Provider.of<MyProvider>(context, listen: false).authData['name']
      );
    });
    super.initState();
  }

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
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    textAlign:
                    lanProvider.isEn ? TextAlign.start : TextAlign.end,
                    style: const TextStyle(fontSize: 23),
                  ),
                ],
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(lanProvider.texts('ok'),
                          style: const TextStyle(
                              fontSize: 19, color: Colors.blue)),
                    ),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed('addMealRes'),
              icon: const Icon(Icons.add),
            ),
          ],
          title: Text(provider.authData['name']??""),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('mainRes/${provider.authData['name']}/meals')
              .snapshots(),
          builder: (ctx, snapshot) {
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length??0,
                itemBuilder: (context, int index) {
                  var resData = snapshot.data!.docs;
                  if (resData.isEmpty)
                    return Center(child: Text("فارغ!"));
                  return Card(
                    elevation: 2.5,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Row(
                              children: [
                                if (resData[index]['imageUrl']!="")
                                  Container(
                                    margin: const EdgeInsets.all(7),
                                    width: width*0.24,
                                    height: height*0.16,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: resData[index]['imageUrl'],
                                        placeholder: (context, url) => const Center(child: const CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: height * 0.02),
                                    Container(
                                      child: Text(
                                        resData[index]['meal name'],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    SizedBox(
                                      width: width*0.4,
                                      child: AutoSizeText(
                                        resData[index]['description'],
                                        maxLines: 3,
                                        minFontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7),
                                        child: Text(
                                          lanProvider.texts('price') +
                                              " " +
                                              resData[index]['meal price'] +
                                              " " +
                                              lanProvider.texts('jd'),
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.pink),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          provider.mealID = resData[index].id;
                                        });
                                        Navigator.of(context)
                                            .pushNamed('editRes');
                                      },
                                      icon: const Icon(Icons.edit),
                                      color: Colors.blue,
                                    ),
                                    IconButton(
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              title: Text(
                                                lanProvider.texts('delete this meal?'),
                                                textAlign: lanProvider.isEn
                                                    ? TextAlign.start
                                                    : TextAlign.end,
                                                style: const TextStyle(fontSize: 23),
                                              ),
                                              contentPadding:
                                              EdgeInsets.symmetric(vertical: 7),
                                              elevation: 24,
                                              content: Container(
                                                height: 30,
                                                child: const Divider(),
                                                alignment: Alignment.topCenter,
                                              ),
                                              actions: [
                                                if (provider.isLoading)
                                                  Center(
                                                      child:
                                                      const CircularProgressIndicator()),
                                                if (!provider.isLoading)
                                                  InkWell(
                                                    child: Text(
                                                      lanProvider.texts('yes?'),
                                                      style: const TextStyle(
                                                          fontSize: 19,
                                                          color: Colors.red),
                                                    ),
                                                    onTap: () async {
                                                      try {
                                                        setState(() {
                                                          provider.mealID =
                                                              resData[index].id;
                                                        });
                                                        Navigator.of(context).pop();
                                                        await provider
                                                            .deleteMeal('mainRes',"meals");
                                                        Fluttertoast.showToast(
                                                            msg: lanProvider
                                                                .texts('Meal Deleted'),
                                                            toastLength:
                                                            Toast.LENGTH_SHORT,
                                                            backgroundColor:
                                                            Colors.grey,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0);
                                                        setState(() {
                                                          provider.isLoading = false;
                                                        });
                                                      } on FirebaseException catch (e) {
                                                        setState(() {
                                                          provider.isLoading = false;
                                                        });
                                                        return dialog(e.message);
                                                      } catch (e) {
                                                        setState(() {
                                                          provider.isLoading = false;
                                                        });
                                                        print(e);
                                                        dialog(lanProvider
                                                            .texts('Error occurred !'));
                                                      }
                                                    },
                                                  ),
                                                const SizedBox(width: 11),
                                                if (!provider.isLoading)
                                                  InkWell(
                                                      child: Text(
                                                          lanProvider.texts('cancel?'),
                                                          style: const TextStyle(
                                                              fontSize: 19)),
                                                      onTap: () =>
                                                          Navigator.of(context).pop()),
                                              ],
                                            );
                                          }),
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

//-------------------------addMeal-----------------------------
class AddMealRes extends StatefulWidget {
  @override
  _AddMealResState createState() => _AddMealResState();
}

class _AddMealResState extends State<AddMealRes> {
  TextEditingController _mealName = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _mealName.dispose();
    _price.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    textAlign:
                    lanProvider.isEn ? TextAlign.start : TextAlign.end,
                    style: const TextStyle(fontSize: 23),
                  ),
                ],
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(lanProvider.texts('ok'),
                          style: const TextStyle(
                              fontSize: 19, color: Colors.blue)),
                    ),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lanProvider.texts('add meal')),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.text,
                controller: _mealName,
                decoration: InputDecoration(
                  labelText: lanProvider.texts('meal name'),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _price,
                decoration: InputDecoration(
                  labelText: lanProvider.texts('meal price'),
                  hintText: "ex: 2.00",
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                controller: _description,
                decoration: InputDecoration(
                  labelText: lanProvider.texts('desc'),
                ),
              ),
              const SizedBox(height: 20),
              if (provider.isLoading)
                Center(child: const CircularProgressIndicator()),
              const SizedBox(height: 20),
              if (!provider.isLoading)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.2),
                  height: height * 0.065,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_mealName.text.isEmpty || _price.text.isEmpty)
                          return dialog(lanProvider.texts('empty field'));
                        setState(() {
                          provider.isLoading = true;
                        });
                        await provider.addMeal(_mealName.text, _price.text,
                            _description.text,'mainRes','meals');
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: lanProvider.texts('Meal Added'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        setState(() {
                          provider.isLoading = false;
                        });
                      } on FirebaseException catch (e) {
                        setState(() {
                          provider.isLoading = false;
                        });
                        return dialog(e.message);
                      } catch (e) {
                        setState(() {
                          provider.isLoading = false;
                        });
                        print(e);
                        dialog(lanProvider.texts('Error occurred !'));
                      }
                    },
                    child: Text(
                      lanProvider.texts('add'),
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
//--------------------------Edit-----------------------------------
class EditRes extends StatefulWidget {
  @override
  _EditResState createState() => _EditResState();
}

class _EditResState extends State<EditRes> {
  TextEditingController _mealName = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _mealName.dispose();
    _price.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      textAlign:
                      lanProvider.isEn ? TextAlign.start : TextAlign.end,
                      style: const TextStyle(fontSize: 23),
                    ),
                  ),
                ],
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(lanProvider.texts('ok'),
                          style: const TextStyle(
                              fontSize: 19, color: Colors.blue)),
                    ),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(lanProvider.texts('edit meal')),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _mealName,
                  decoration: InputDecoration(
                    labelText: lanProvider.texts('meal name'),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _price,
                  decoration: InputDecoration(
                      labelText: lanProvider.texts('meal price'),
                      hintText: "ex: 2.00"),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _description,
                  decoration: InputDecoration(
                    labelText: lanProvider.texts('desc'),
                  ),
                ),
                const SizedBox(height: 30),
                if (provider.isLoading)
                  const Center(child: const CircularProgressIndicator()),
                if (!provider.isLoading)
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            provider.isLoading = true;
                          });
                          await provider.editMeal(_mealName.text, _price.text,
                              _description.text,'mainRes','meals');
                          Navigator.of(context).pop();
                          setState(() {
                            provider.isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            provider.isLoading = false;
                          });
                          dialog(e.message);
                          print(e);
                        } catch (e) {
                          setState(() {
                            provider.isLoading = false;
                          });
                          dialog(lanProvider.texts('Error occurred !'));
                          print(e);
                        }
                      },
                      child: Text(lanProvider.texts('save'))),
              ],
            ),
          ),
        ));
  }
}
