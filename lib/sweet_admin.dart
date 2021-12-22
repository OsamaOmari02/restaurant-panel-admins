import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/drawer.dart';
import 'package:restaurants_panel/provider.dart';

import 'provider.dart';
import 'languageProvider.dart';

class AdminSweets extends StatefulWidget {
  @override
  _AdminSweetsState createState() => _AdminSweetsState();
}

var tab1s;
var tab2s;
var tab3s;
var tab4s;
var tab5s;
var tab6s;
var tab7s;
var tab8s;
var tabGateau;

class _AdminSweetsState extends State<AdminSweets> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).authData['name']=='الصالون الأخضر-السوق'?
      Provider.of<MyProvider>(context, listen: false).tabIndex = "kunafeh":
      Provider.of<MyProvider>(context, listen: false).tabIndex = "gateau";
      Provider.of<MyProvider>(context,listen: false).fetch();
      Provider.of<MyProvider>(context, listen: false).fetchMealsSweets(
          Provider.of<MyProvider>(context, listen: false).authData['name']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: DefaultTabController(
          length: Provider.of<MyProvider>(context, listen: false)
              .authData['name'] ==
              'نفيسة'
              ? 4
              : Provider.of<MyProvider>(context, listen: false).authData['name'] ==
              'الصالون الأخضر-شويكة'
              ? 8
              : 3,
          child: Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('addMealSweets'),
                  icon: const Icon(Icons.add),
                ),
              ],
              centerTitle: true,
              title: Text(Provider.of<MyProvider>(context).authData['name']??""),
              bottom: TabBar(
                padding:Provider.of<MyProvider>(context, listen: false)
                  .authData['name'] ==
                  'الصالون الأخضر-شويكة'
                  ? EdgeInsets.symmetric(horizontal: width * 0.05)
                  : EdgeInsets.symmetric(horizontal: width * 0.08),
                isScrollable: true,
                tabs: [
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'نفيسة' ||
                      Provider.of<MyProvider>(context, listen: false)
                          .authData['name'] ==
                          'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabNafesa')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabSweets')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tab4')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabSnacks')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabPizza&mnaqish')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabRolls')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabWaffle')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabCocktail')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-شويكة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tab5')),
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tab3')),
                ],
                onTap: (index) {
                  if (index == 0 && Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-السوق')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "kunafeh";
                  else if (index == 0)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "gateau";
                  else if (index == 1 && Provider.of<MyProvider>(context, listen: false)
                  .authData['name'] ==
                  'الصالون الأخضر-السوق')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "cake";
                  else if (index == 1 && (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'نفيسة' || Provider.of<MyProvider>(context, listen: false)
                  .authData['name'] ==
                  'الصالون الأخضر-شويكة'))
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "kunafeh";
                  else if (index == 2 && Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-السوق')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "others";
                  else if (index == 2 && Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'نفيسة')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "cake";
                  else if (index == 2 && Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "snacks";
                  else if (index == 3 && Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'نفيسة')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "others";
                  else if (index == 3)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "pizza";
                  else if (index == 4)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "rolls";
                  else if (index == 5)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "waffle";
                  else if (index == 6)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "ice cream";
                  else if (index == 7)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "others";

                  print('index = ${Provider.of<MyProvider>(context,listen: false).tabIndex}\n');
                },
              ),
            ),
            body: Stack(children: [
              TabBarView(
                children: <Widget>[
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'نفيسة' ||
                      Provider.of<MyProvider>(context, listen: false)
                          .authData['name'] ==
                          'الصالون الأخضر-شويكة')
                    GateauAdmin(),
                  FirstAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    SnacksAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    PizzaAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    RollsAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    WaffleAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                    IceCreamAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-شويكة')
                    SecondAdmin(),
                  ThirdAdmin(),
                ],
              ),
            ]),
          ),
        ));
  }
}

//-------------------------addMeal-----------------------------
class AddMealSweets extends StatefulWidget {
  @override
  _AddMealSweetsState createState() => _AddMealSweetsState();
}

class _AddMealSweetsState extends State<AddMealSweets> {
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

  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;
  getHeight() => height = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);

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
    Future pickImage(ImageSource src) async {
      try {
        var image = (await ImagePicker().pickImage(source: src,imageQuality: 100));
        if (image == null) return;
        setState(() {
          Provider.of<MyProvider>(context,listen: false).file = File(image.path);
        });
        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        dialog(lanProvider.texts('Error occurred !'));
        print(e.message);
      } catch (e) {
        print(e);
      }
    }
    dialog2() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return Directionality(
              textDirection:
              lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
              child: AlertDialog(
                title: Text(
                  lanProvider.texts('choose one'),
                  style: const TextStyle(fontSize: 23),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 7),
                elevation: 24,
                content: Container(
                  height: getHeight() * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(Icons.add_photo_alternate,
                                  color: Colors.blue),
                            ),
                            Text(
                              lanProvider.texts('gallery'),
                              style: const TextStyle(
                                  fontSize: 19, color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () => pickImage(ImageSource.gallery),
                      ),
                      const SizedBox(width: 11),
                      InkWell(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              lanProvider.texts('camera'),
                              style: const TextStyle(
                                  fontSize: 19, color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () => pickImage(ImageSource.camera),
                      ),
                    ],
                  ),
                ),
                actions: [],
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _mealName,
                  decoration: InputDecoration(
                    labelText: lanProvider.texts('meal name'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _price,
                  decoration: InputDecoration(
                    labelText: lanProvider.texts('meal price'),
                    hintText: "ex: 2.00",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _description,
                  decoration: InputDecoration(
                    labelText: lanProvider.texts('desc'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () => dialog2(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_a_photo),
                      const SizedBox(width: 10),
                      Text(lanProvider.texts('add image')),
                      if (Provider.of<MyProvider>(context).file != null) SizedBox(width: getWidth() * 0.1),
                      if (Provider.of<MyProvider>(context).file != null)
                        IconButton(
                            onPressed: () => Provider.of<MyProvider>(context,listen: false).deleteImage(),
                            icon: Icon(Icons.delete, color: Colors.red)),
                    ],
                  )),
              Provider.of<MyProvider>(context).file == null
                  ? SizedBox(height: 20)
                  : Container(
                padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.3),
                height: getHeight() * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    File(Provider.of<MyProvider>(context).file!.path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              if (Provider.of<MyProvider>(context).isLoading)
                Center(child: const CircularProgressIndicator()),
              if (!Provider.of<MyProvider>(context).isLoading)
                Center(
                  child: Text(
                    lanProvider.texts('add text'),
                    style: TextStyle(fontSize: getWidth() * 0.037),
                  ),
                ),
              const SizedBox(height: 10),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-شويكة')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_mealName.text.isEmpty || _price.text.isEmpty)
                          return dialog(lanProvider.texts('empty field'));
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = true;
                        });
                        await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                            _description.text,'sweets',"kunafeh");
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: lanProvider.texts('Meal Added'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = false;
                        });
                      } on FirebaseException catch (e) {
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = false;
                        });
                        return dialog(e.message);
                      } catch (e) {
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = false;
                        });
                        print(e);
                        dialog(lanProvider.texts('Error occurred !'));
                      }
                    },
                    child: Text(
                      lanProvider.texts('tab4'),
                      style: TextStyle(fontSize: getWidth() * 0.05),
                    ),
                  ),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-شويكة')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-شويكة')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"cake");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tab5'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-شويكة')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-السوق')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"gateau");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tabNafesa'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'الصالون الأخضر-السوق')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"kunafeh");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tabSweets'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"snacks");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tabSnacks'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"pizza");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tabPizza&mnaqish'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"rolls");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tabRolls'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"waffle");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tabWaffle'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                Container(
                  height: getHeight() * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"ice cream");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tabCocktail'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الصالون الأخضر-شويكة')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading)
                Container(
                  height: getHeight() * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text,'sweets',"others");
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          return dialog(e.message);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tab3'),
                        style: TextStyle(fontSize: getWidth() * 0.05),
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
//--------------------------Edit-----------------------------------
class EditSweets extends StatefulWidget {
  @override
  _EditSweetsState createState() => _EditSweetsState();
}

class _EditSweetsState extends State<EditSweets> {
  TextEditingController _mealName = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void initState() {
    _mealName = TextEditingController(text:Provider.of<MyProvider>(context,listen: false).mealNameCont);
    _price = TextEditingController(text:Provider.of<MyProvider>(context,listen: false).mealPriceCont);
    _description = TextEditingController(text:Provider.of<MyProvider>(context,listen: false).mealDescCont);
    super.initState();
  }

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
    Future pickImage(ImageSource src) async {
      try {
        var image = (await ImagePicker().pickImage(source: src,imageQuality: 100));
        if (image == null) return;
        setState(() {
          Provider.of<MyProvider>(context,listen: false).file = File(image.path);
        });
        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        dialog(lanProvider.texts('Error occurred !'));
        print(e.message);
      } catch (e) {
        print(e);
      }
    }
    dialog2() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return Directionality(
              textDirection:
              lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
              child: AlertDialog(
                title: Text(
                  lanProvider.texts('choose one'),
                  style: const TextStyle(fontSize: 23),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 7),
                elevation: 24,
                content: Container(
                  height: height * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(Icons.add_photo_alternate,
                                  color: Colors.blue),
                            ),
                            Text(
                              lanProvider.texts('gallery'),
                              style: const TextStyle(
                                  fontSize: 19, color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () => pickImage(ImageSource.gallery),
                      ),
                      const SizedBox(width: 11),
                      InkWell(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: const Icon(
                                Icons.add_a_photo,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              lanProvider.texts('camera'),
                              style: const TextStyle(
                                  fontSize: 19, color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () => pickImage(ImageSource.camera),
                      ),
                    ],
                  ),
                ),
              ),
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
            child: ListView(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _mealName,
                    decoration: InputDecoration(
                      labelText: lanProvider.texts('meal name'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _price,
                    decoration: InputDecoration(
                        labelText: lanProvider.texts('meal price'),
                        hintText: "ex: 2.00"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _description,
                    decoration: InputDecoration(
                      labelText: lanProvider.texts('desc'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () => dialog2(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_a_photo),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(lanProvider.texts('add image')),
                        if (Provider.of<MyProvider>(context).file != null) SizedBox(width: width * 0.1),
                        if (Provider.of<MyProvider>(context).file != null)
                          IconButton(
                              onPressed: () => Provider.of<MyProvider>(context,listen: false).deleteImage(),
                              icon: Icon(Icons.delete, color: Colors.red)),
                      ],
                    )),
                Provider.of<MyProvider>(context).file == null
                    ? SizedBox(height: 20)
                    : Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.28),
                  height: height * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(
                      File(Provider.of<MyProvider>(context).file!.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                if (Provider.of<MyProvider>(context).file == null &&
                    Provider.of<MyProvider>(context).tempFile != null &&
                    Provider.of<MyProvider>(context).tempFile != '')
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                    height: height * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: Provider.of<MyProvider>(context).tempFile,
                        placeholder: (context, url) => const Center(
                            child: const CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                if (Provider.of<MyProvider>(context).isLoading)
                  const Center(child: const CircularProgressIndicator()),
                if (!Provider.of<MyProvider>(context).isLoading)
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).editMeal(_mealName.text, _price.text,
                              _description.text, 'sweets',Provider.of<MyProvider>(context,listen: false).tabIndex);
                          Navigator.of(context).pop();
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                        } on FirebaseException catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          dialog(e.message);
                          print(e);
                        } catch (e) {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
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
//-------------------------------1----------------------------
class FirstAdmin extends StatefulWidget {
  @override
  _FirstAdminState createState() => _FirstAdminState();
}

class _FirstAdminState extends State<FirstAdmin> {
  @override
  void initState() {
    tab1s = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/kunafeh').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tab1s,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.52,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
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
                                            fontSize: 15, color: Colors.pink),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context,listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context,listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context,listen: false)
                                                          .deleteMeal('sweets',"kunafeh");
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
                                                        Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                      });

                                                    } on FirebaseException catch (e) {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                      print(e);
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}

//-----------------------2--------------------------
class SecondAdmin extends StatefulWidget {
  @override
  _SecondAdminState createState() => _SecondAdminState();
}

class _SecondAdminState extends State<SecondAdmin> {

  @override
  void initState() {
    tab2s = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/cake').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tab2s,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context,listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context, listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context, listen: false)
                                                          .deleteMeal('sweets','cake');
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
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}

//-----------------------------3-----------------------
class ThirdAdmin extends StatefulWidget {
  @override
  _ThirdAdminState createState() => _ThirdAdminState();
}

class _ThirdAdminState extends State<ThirdAdmin> {

  @override
  void initState() {
    tab3s = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/others').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tab3s,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13.5,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context, listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context, listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context, listen: false)
                                                          .deleteMeal('sweets',"others");
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
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}

//----------------------------GateauAdmin----------------
class GateauAdmin extends StatefulWidget {
  @override
  _GateauAdminState createState() => _GateauAdminState();
}

class _GateauAdminState extends State<GateauAdmin> {

  @override
  void initState() {
    tabGateau = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/gateau').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tabGateau,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13.5,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context, listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context, listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context, listen: false)
                                                          .deleteMeal('sweets',"gateau");
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
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}

//--------------------------SnacksAdmin--------------------
class SnacksAdmin extends StatefulWidget {
  @override
  _SnacksAdminState createState() => _SnacksAdminState();
}

class _SnacksAdminState extends State<SnacksAdmin> {

  @override
  void initState() {
    tab4s = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/snacks').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tab4s,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13.5,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context, listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context, listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context, listen: false)
                                                          .deleteMeal('sweets',"snacks");
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
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}

//-------------------------PizzaAdmin------------------------
class PizzaAdmin extends StatefulWidget {
  @override
  _PizzaAdminState createState() => _PizzaAdminState();
}

class _PizzaAdminState extends State<PizzaAdmin> {

  @override
  void initState() {
    tab5s = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/pizza').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tab5s,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13.5,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context, listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context, listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context, listen: false)
                                                          .deleteMeal('sweets',"pizza");
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
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}

//-------------------------RollsAdmin------------------------
class RollsAdmin extends StatefulWidget {
  @override
  _RollsAdminState createState() => _RollsAdminState();
}

class _RollsAdminState extends State<RollsAdmin> {

  @override
  void initState() {
    tab6s = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/rolls').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tab6s,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13.5,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context, listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context, listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context, listen: false)
                                                          .deleteMeal('sweets',"rolls");
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
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}

//-------------------------WaffleAdmin------------------------
class WaffleAdmin extends StatefulWidget {
  @override
  _WaffleAdminState createState() => _WaffleAdminState();
}

class _WaffleAdminState extends State<WaffleAdmin> {

  @override
  void initState() {
    tab7s = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/waffle').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tab7s,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13.5,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context, listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context, listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context, listen: false)
                                                          .deleteMeal('sweets',"waffle");
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
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}

//-------------------------IceCreamAdmin------------------------
class IceCreamAdmin extends StatefulWidget {
  @override
  _IceCreamAdminState createState() => _IceCreamAdminState();
}

class _IceCreamAdminState extends State<IceCreamAdmin> {

  @override
  void initState() {
    tab8s = FirebaseFirestore.instance
        .collection('/sweets/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/ice cream').orderBy('meal name')
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: tab8s,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return  Card(
                  elevation: 2.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              if (resData[index]['imageUrl'] != "")
                                Container(
                                  margin: const EdgeInsets.all(7),
                                  width: width * 0.24,
                                  height: height * 0.16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: resData[index]['imageUrl'],
                                      placeholder: (context, url) => const Center(
                                          child:
                                          const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: width * 0.54,
                                    child: AutoSizeText(
                                      resData[index]['meal name'],
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13.5,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: AutoSizeText(
                                      resData[index]['description'],
                                      maxLines: 3,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                        Provider.of<MyProvider>(context,listen: false).mealNameCont = resData[index]['meal name'];
                                        Provider.of<MyProvider>(context,listen: false).mealPriceCont = resData[index]['meal price'];
                                        Provider.of<MyProvider>(context,listen: false).mealDescCont = resData[index]['description']??'';
                                        Provider.of<MyProvider>(context, listen: false).mealID = resData[index].id;
                                        if (resData[index]['imageUrl']!='')
                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('editSweets');
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
                                              lanProvider
                                                  .texts('delete this meal?'),
                                              textAlign: lanProvider.isEn
                                                  ? TextAlign.start
                                                  : TextAlign.end,
                                              style:
                                              const TextStyle(fontSize: 23),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 24,
                                            content: Container(
                                              height: 30,
                                              child: const Divider(),
                                              alignment: Alignment.topCenter,
                                            ),
                                            actions: [
                                              if (Provider.of<MyProvider>(context).isLoading)
                                                Center(
                                                    child:
                                                    const CircularProgressIndicator()),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
                                                        Provider.of<MyProvider>(context, listen: false).mealID =
                                                            resData[index].id;
                                                        if (resData[index]['imageUrl']!='')
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context, listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context).pop();
                                                      await Provider.of<MyProvider>(context, listen: false)
                                                          .deleteMeal('sweets',"ice cream");
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
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      return dialog(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context, listen: false).isLoading = false;
                                                      });
                                                      dialog(lanProvider
                                                          .texts('Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
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
    );
  }
}




