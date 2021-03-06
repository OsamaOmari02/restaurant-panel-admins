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

class AdminShawarma extends StatefulWidget {
  @override
  _AdminShawarmaState createState() => _AdminShawarmaState();
}
var tab1sh;
var tab2sh;
var tab3sh;
var tab4sh;
var tab5sh;
var tab6sh;
var tab7sh;
var tab8sh;
var tab9sh;

class _AdminShawarmaState extends State<AdminShawarma> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).tabIndex = "shawarma";
      Provider.of<MyProvider>(context, listen: false).fetch();
      Provider.of<MyProvider>(context, listen: false).fetchMealsShawarma(
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
          length: Provider.of<MyProvider>(context).authData['name'] ==
              'Snap Burger' ||
              Provider.of<MyProvider>(context).authData['name'] == 'شاورما هنية'
              ? 2
              : Provider.of<MyProvider>(context).authData['name'] == 'الدويري' ||
              Provider.of<MyProvider>(context).authData['name'] == 'هون وبس'
              ? 5
              : 3,
          child: Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('addMeal'),
                  icon: const Icon(Icons.add),
                ),
              ],
              centerTitle: true,
              title: Text(Provider.of<MyProvider>(context).authData['name'] ?? ""),
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  if (Provider.of<MyProvider>(context).authData['name'] ==
                      'هون وبس')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tab1edited')),
                  if (Provider.of<MyProvider>(context).authData['name'] !=
                      'Snap Burger' &&
                      Provider.of<MyProvider>(context).authData['name'] !=
                          'هون وبس')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tab1')),
                  if (Provider.of<MyProvider>(context).authData['name'] !=
                      'شاورما هنية' &&
                      Provider.of<MyProvider>(context).authData['name'] !=
                          'الدويري' &&
                      Provider.of<MyProvider>(context).authData['name'] !=
                          'هون وبس')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tab2')),
                  if (Provider.of<MyProvider>(context).authData['name'] ==
                      'هون وبس')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabfalafel&snacks')),
                  if (Provider.of<MyProvider>(context).authData['name'] ==
                      'هون وبس')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabmo3ajanat')),
                  if (Provider.of<MyProvider>(context).authData['name'] ==
                      'هون وبس')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabHummus')),
                  if (Provider.of<MyProvider>(context).authData['name'] ==
                      'الدويري')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabChicken')),
                  if (Provider.of<MyProvider>(context).authData['name'] ==
                      'الدويري')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabDwairy')),
                  if (Provider.of<MyProvider>(context).authData['name'] ==
                      'الدويري')
                    Tab(
                        text: Provider.of<LanProvider>(context, listen: false)
                            .texts('tabBreakFast')),
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tab3')),
                ],
                onTap: (index) {
                  if (index == 0 && Provider.of<MyProvider>(context,listen: false).authData['name'] !=
                  'Snap Burger')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "shawarma";
                  else if (index==0 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                  'Snap Burger')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "snacks";
                  else if (index==1 && Provider.of<MyProvider>(context,listen: false).authData['name'] !=
                      'شاورما هنية' &&
                      Provider.of<MyProvider>(context,listen: false).authData['name'] !=
                          'الدويري' &&
                      Provider.of<MyProvider>(context,listen: false).authData['name'] !=
                          'هون وبس' &&
                      Provider.of<MyProvider>(context,listen: false).authData['name'] !=
                          'Snap Burger')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "snacks";
                  else if (index==1 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                      'الدويري')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "Chicken";
                  else if (index==2 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                      'الدويري')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "Aldwairy";
                  else if (index==3 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                      'الدويري')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "BreakFast";

                  else if (index==1 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                      'هون وبس')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "Falafel";
                  else if (index==2 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                      'هون وبس')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "Mo3ajanat";
                  else if (index==3 && Provider.of<MyProvider>(context,listen: false).authData['name'] ==
                      'هون وبس')
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "Hummus";
                  else
                    Provider.of<MyProvider>(context,listen: false).tabIndex = "others";

                  print('index = ${Provider.of<MyProvider>(context,listen: false).tabIndex}\n');
                },
              ),
            ),
            body: Stack(children: [
              TabBarView(
                children: <Widget>[
                  if (Provider.of<MyProvider>(context).authData['name'] !=
                      'Snap Burger')
                    FirstAdmin(),
                  if (Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
                    FalafelAdmin(),
                  if (Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
                    Mo3ajanatAdmin(),
                  if (Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
                    HummusAdmin(),
                  if (Provider.of<MyProvider>(context).authData['name'] !=
                      'شاورما هنية' &&
                      Provider.of<MyProvider>(context).authData['name'] !=
                          'الدويري' &&
                      Provider.of<MyProvider>(context).authData['name'] != 'هون وبس')
                    SecondAdmin(),
                  if (Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
                    ChickenAdmin(),
                  if (Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
                    AldwairyAdmin(),
                  if (Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
                    BreakFastAdmin(),
                  ThirdAdmin(),
                ],
              ),
            ]),
          ),
        ));
  }
}

//--------------------------Edit-----------------------------------
class EditShawarma extends StatefulWidget {
  @override
  _EditShawarmaState createState() => _EditShawarmaState();
}

class _EditShawarmaState extends State<EditShawarma> {
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
                              _description.text, 'shawarma', Provider.of<MyProvider>(context,listen: false).tabIndex);
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
class AddMealShawarma extends StatefulWidget {
  @override
  _AddMealShawarmaState createState() => _AddMealShawarmaState();
}

class _AddMealShawarmaState extends State<AddMealShawarma> {
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
              if (!Provider.of<MyProvider>(context).isLoading && Provider.of<MyProvider>(context).authData['name'] !=
                  'Snap Burger')
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
                            _description.text, 'shawarma', "shawarma");
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
                      lanProvider.texts('tab1'),
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] != 'شاورما هنية' &&
                  Provider.of<MyProvider>(context).authData['name'] != 'الدويري' &&
                  Provider.of<MyProvider>(context).authData['name'] != 'هون وبس')
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
                              _description.text, 'shawarma', "snacks");
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
                        lanProvider.texts('tab2'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] != 'شاورما هنية' &&
                  Provider.of<MyProvider>(context).authData['name'] != 'الدويري' &&
                  Provider.of<MyProvider>(context).authData['name'] != 'هون وبس')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
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
                              _description.text, 'shawarma', "Falafel");
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
                        lanProvider.texts('tabfalafel&snacks'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
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
                              _description.text, 'shawarma', "Mo3ajanat");
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
                        lanProvider.texts('tabmo3ajanat'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
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
                              _description.text, 'shawarma', "Hummus");
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
                        lanProvider.texts('tabHummus'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'هون وبس')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
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
                              _description.text, 'shawarma', "Chicken");
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
                        lanProvider.texts('tabChicken'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
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
                              _description.text, 'shawarma', "Aldwairy");
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
                        lanProvider.texts('tabDwairy'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
              const SizedBox(height: 20),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
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
                              _description.text, 'shawarma', "BreakFast");
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
                        lanProvider.texts('tabBreakFast'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              if (!Provider.of<MyProvider>(context).isLoading &&
                  Provider.of<MyProvider>(context).authData['name'] == 'الدويري')
              const SizedBox(height: 20),
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
                              _description.text, 'shawarma', "others");
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
      tab1sh = FirebaseFirestore.instance
          .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
          .authData['name']}/shawarma').orderBy('meal name')
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
        stream: tab1sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma",
                                                          'shawarma');
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
      tab2sh = FirebaseFirestore.instance
          .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
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
        stream: tab2sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma", 'snacks');
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
      tab3sh = FirebaseFirestore.instance
          .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
          .authData['name']}/others').orderBy("meal name")
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
        stream: tab3sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma", 'others');
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

//-------------------------------------هون وبس------------------------------
//-----------------------FalafelAdmin--------------------------------
class FalafelAdmin extends StatefulWidget {
  @override
  _FalafelAdminState createState() => _FalafelAdminState();
}

class _FalafelAdminState extends State<FalafelAdmin> {

  @override
  void initState() {
    tab4sh = FirebaseFirestore.instance
        .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/Falafel').orderBy("meal name")
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
        stream: tab4sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma", 'Falafel');
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

//--------------------------------Mo3ajanatAdmin------------------------
class Mo3ajanatAdmin extends StatefulWidget {
  @override
  _Mo3ajanatAdminState createState() => _Mo3ajanatAdminState();
}

class _Mo3ajanatAdminState extends State<Mo3ajanatAdmin> {

  @override
  void initState() {
    tab5sh = FirebaseFirestore.instance
        .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/Mo3ajanat').orderBy("meal name")
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
        stream: tab5sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma", 'Mo3ajanat');
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

//--------------------------HummusAdmin--------------------------
class HummusAdmin extends StatefulWidget {
  @override
  _HummusAdminState createState() => _HummusAdminState();
}

class _HummusAdminState extends State<HummusAdmin> {

  @override
  void initState() {
    tab6sh = FirebaseFirestore.instance
        .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/Hummus').orderBy("meal name")
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
        stream: tab6sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma", 'Hummus');
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

//---------------------------الدويري-----------------------------
//-------------------------ChickenAdmin------------------------
class ChickenAdmin extends StatefulWidget {
  @override
  _ChickenAdminState createState() => _ChickenAdminState();
}

class _ChickenAdminState extends State<ChickenAdmin> {

  @override
  void initState() {
    tab7sh = FirebaseFirestore.instance
        .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/Chicken').orderBy("meal name")
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
        stream: tab7sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma", 'Chicken');
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

//------------------------------AldwairyAdmin----------------------
class AldwairyAdmin extends StatefulWidget {
  @override
  _AldwairyAdminState createState() => _AldwairyAdminState();
}

class _AldwairyAdminState extends State<AldwairyAdmin> {

  @override
  void initState() {
    tab8sh = FirebaseFirestore.instance
        .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/Aldwairy').orderBy("meal name")
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
        stream: tab8sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma", 'Aldwairy');
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

//------------------------------BreakFastAdmin----------------------
class BreakFastAdmin extends StatefulWidget {
  @override
  _BreakFastAdminState createState() => _BreakFastAdminState();
}

class _BreakFastAdminState extends State<BreakFastAdmin> {

  @override
  void initState() {
    tab9sh = FirebaseFirestore.instance
        .collection('/shawarma/${Provider.of<MyProvider>(context, listen: false)
        .authData['name']}/BreakFast').orderBy("meal name")
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
        stream: tab9sh,
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
                                          .pushNamed('editShawarma');
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
                                                          "shawarma", 'BreakFast');
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