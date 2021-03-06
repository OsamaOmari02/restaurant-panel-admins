import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/provider.dart';

import 'drawer.dart';
import 'languageProvider.dart';

class Admin2Drinks extends StatefulWidget {
  @override
  _Admin2DrinksState createState() => _Admin2DrinksState();
}
var tab1p;
var tab2p;
var tab3p;
var tab4p;
var tab5p;
var tab6p;
var tab7p;
var tab8p;
var tab9p;

class _Admin2DrinksState extends State<Admin2Drinks> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).tabIndex = "milk";
      Provider.of<MyProvider>(context, listen: false).fetch();
      Provider.of<MyProvider>(context, listen: false).fetchMealsDrinks(
          Provider.of<MyProvider>(context, listen: false).authData['name']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: DefaultTabController(
          length: Provider.of<MyProvider>(context, listen: false).authData['name'] ==
              'لبناني الشمال'
              ? 7
              : 3,
          child: Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('addMeal2Drinks'),
                  icon: const Icon(Icons.add),
                ),
              ],
              centerTitle: true,
              title: Text(Provider.of<MyProvider>(context).authData['name'] ?? ""),
              bottom: TabBar(
                isScrollable: Provider.of<MyProvider>(context, listen: false)
                    .authData['name'] ==
                    'لبناني الشمال'
                    ? true
                    : false,
                tabs: [
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabMilk')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabCockTail')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabNaturalDrinks')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabSpecial')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabSlushDrinks')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabSalads')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabWaffles&Pancakes')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الحفرة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabMixes')),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'الحفرة')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabHot')),
                ],
                onTap: (index) {
                  if (index == 0)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "milk";
                  else if (index == 1 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                      'لبناني الشمال')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "natural cocktail";
                  else if (index == 1)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "mixes";
                  else if (index==2 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                      'لبناني الشمال')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "natural drinks";
                  else if (index==2)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "hot drinks";
                  else if (index==3)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "special cocktail";
                  else if (index==4)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "natural slush";
                  else if (index==5)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "fruits salads";
                  else if (index==6)
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "waffle";

                  print('index = ${Provider.of<MyProvider>(context,listen: false).tabIndex}\n');
                },
              ),
            ),
            body: Stack(children: [
              TabBarView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  FirstAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    NaturalCocktailAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    NaturalDrinksAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    SpecialCocktailAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    NaturalSlushAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    FruitsSaladsAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] ==
                      'لبناني الشمال')
                    CrepeAndWafflsAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'لبناني الشمال')
                    SecondAdmin(),
                  if (Provider.of<MyProvider>(context, listen: false)
                      .authData['name'] !=
                      'لبناني الشمال')
                    ThirdAdmin(),
                ],
              ),
            ]),
          ),
        ));
  }
}

//--------------------------Edit-----------------------------------
class Edit2Drinks extends StatefulWidget {
  @override
  _Edit2DrinksState createState() => _Edit2DrinksState();
}

class _Edit2DrinksState extends State<Edit2Drinks> {
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
        var image = (await ImagePicker().pickImage(source: src,imageQuality: 50));
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
                              _description.text, 'drinks', Provider.of<MyProvider>(context,listen: false).tabIndex);
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

//-------------------------addMeal-----------------------------
class AddMeal2Drinks extends StatefulWidget {
  @override
  _AddMeal2DrinksState createState() => _AddMeal2DrinksState();
}

class _AddMeal2DrinksState extends State<AddMeal2Drinks> {
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
    Future pickImage(ImageSource src) async {
      try {
        var image = (await ImagePicker().pickImage(source: src,imageQuality: 50));
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
                padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                height: height * 0.2,
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
                    style: TextStyle(fontSize: width * 0.037),
                  ),
                ),
              const SizedBox(height: 10),
              if (!Provider.of<MyProvider>(context).isLoading)
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_mealName.text.isEmpty || _price.text.isEmpty)
                          return dialog(lanProvider.texts('empty field'));
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = true;
                        });
                        await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                            _description.text, 'drinks', "milk");
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
                      lanProvider.texts('tabMilk'),
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الحفرة')
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text, 'drinks', "mixes");
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
                        lanProvider.texts('tabMixes'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الحفرة')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الحفرة')
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text, 'drinks', "hot drinks");
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
                        lanProvider.texts('tabHot'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الحفرة')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text, 'drinks', "natural cocktail");
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
                        lanProvider.texts('tabCockTail'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text, 'drinks', "natural drinks");
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
                        lanProvider.texts('tabNaturalDrinks'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text, 'drinks', "special cocktail");
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
                        lanProvider.texts('tabSpecial'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text, 'drinks', "natural slush");
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
                        lanProvider.texts('tabSlushDrinks'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text, 'drinks', "fruits salads");
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
                        lanProvider.texts('tabSalads'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'لبناني الشمال')
                Container(
                  height: height * 0.055,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addMeal(_mealName.text, _price.text,
                              _description.text, 'drinks', "waffle");
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
                        lanProvider.texts('tabWaffles&Pancakes'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
            ],
          ),
        ),
      ),
    );
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
    tab1p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/milk').orderBy('meal name')
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
        stream: tab1p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                                          Provider.of<MyProvider>(context,listen: false).tempFile =
                                                          resData[index]
                                                          ['imageUrl'];
                                                        else
                                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks",
                                                          'milk');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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
    tab2p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/mixes').orderBy('meal name')
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
        stream: tab2p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                            const EdgeInsets.symmetric(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks", 'mixes');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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
    tab3p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/hot drinks').orderBy("meal name")
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
        stream: tab3p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                            const EdgeInsets.symmetric(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks", 'hot drinks');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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

//-------------------------------------لبناني الشمال------------------------------
//-----------------------NaturalCocktailAdmin--------------------------------
class NaturalCocktailAdmin extends StatefulWidget {
  @override
  _NaturalCocktailAdminState createState() => _NaturalCocktailAdminState();
}

class _NaturalCocktailAdminState extends State<NaturalCocktailAdmin> {

  @override
  void initState() {
    tab4p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/natural cocktail').orderBy("meal name")
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
        stream: tab4p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                            const EdgeInsets.symmetric(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks", 'natural cocktail');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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

//--------------------------------NaturalDrinksAdmin------------------------
class NaturalDrinksAdmin extends StatefulWidget {
  @override
  _NaturalDrinksAdminState createState() => _NaturalDrinksAdminState();
}

class _NaturalDrinksAdminState extends State<NaturalDrinksAdmin> {

  @override
  void initState() {
    tab5p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/natural drinks').orderBy("meal name")
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
        stream: tab5p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                            const EdgeInsets.symmetric(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks", 'natural drinks');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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

//--------------------------SpecialCocktailAdmin--------------------------
class SpecialCocktailAdmin extends StatefulWidget {
  @override
  _SpecialCocktailAdminState createState() => _SpecialCocktailAdminState();
}

class _SpecialCocktailAdminState extends State<SpecialCocktailAdmin> {

  @override
  void initState() {
    tab6p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/special cocktail').orderBy("meal name")
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
        stream: tab6p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                            const EdgeInsets.symmetric(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks", 'special cocktail');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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

//-------------------------NaturalSlushAdmin------------------------
class NaturalSlushAdmin extends StatefulWidget {
  @override
  _NaturalSlushAdminState createState() => _NaturalSlushAdminState();
}

class _NaturalSlushAdminState extends State<NaturalSlushAdmin> {

  @override
  void initState() {
    tab7p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/natural slush').orderBy("meal name")
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
        stream: tab7p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                            const EdgeInsets.symmetric(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks", 'natural slush');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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

//------------------------------FruitsSaladsAdmin----------------------
class FruitsSaladsAdmin extends StatefulWidget {
  @override
  _FruitsSaladsAdminState createState() => _FruitsSaladsAdminState();
}

class _FruitsSaladsAdminState extends State<FruitsSaladsAdmin> {

  @override
  void initState() {
    tab8p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/fruits salads').orderBy("meal name")
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
        stream: tab8p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                            const EdgeInsets.symmetric(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks", 'fruits salads');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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

//------------------------------CrepeAndWafflsAdmin----------------------
class CrepeAndWafflsAdmin extends StatefulWidget {
  @override
  _CrepeAndWafflsAdminState createState() => _CrepeAndWafflsAdminState();
}

class _CrepeAndWafflsAdminState extends State<CrepeAndWafflsAdmin> {

  @override
  void initState() {
    tab9p = FirebaseFirestore.instance
        .collection('/drinks/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/waffle').orderBy("meal name")
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
        stream: tab9p,
        builder: (ctx, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text(lanProvider.texts('something went wrong !')));
          if (snapshot.connectionState==ConnectionState.waiting)
            return const Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, int index) {
                var resData = snapshot.data!.docs;
                return Card(
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
                                          Provider.of<MyProvider>(context,listen: false).tempFile = resData[index]
                                          ['imageUrl'];
                                        else
                                          Provider.of<MyProvider>(context,listen: false).tempFile = null;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('edit2Drinks');
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
                                            const EdgeInsets.symmetric(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Provider.of<MyProvider>(context,listen: false).deleteMeal(
                                                          "drinks", 'waffle');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                    } on FirebaseException catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        Provider.of<MyProvider>(context,listen: false).isLoading =
                                                        false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!Provider.of<MyProvider>(context).isLoading)
                                                InkWell(
                                                    child: Text(
                                                        lanProvider
                                                            .texts('cancel?'),
                                                        style: const TextStyle(
                                                            fontSize: 19)),
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop()),
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