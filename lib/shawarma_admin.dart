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
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: DefaultTabController(
          length: 3,
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
              title: Text(provider.authData['name']??""),
              bottom: TabBar(
                tabs: [
                  Tab(text: lanProvider.texts('tab1')),
                  Tab(text: lanProvider.texts('tab2')),
                  Tab(text: lanProvider.texts('tab3')),
                ],
                onTap: (index) {
                  if (index == 0)
                    provider.tabIndex = "shawarma";
                  else if (index == 1)
                    provider.tabIndex = "snacks";
                  else
                    provider.tabIndex = "others";
                },
              ),
            ),
            body: Stack(children: [
              TabBarView(
                children: <Widget>[
                  FirstAdmin(),
                  SecondAdmin(),
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
        var image = (await ImagePicker().pickImage(source: src));
        if (image == null) return;
        setState(() {
          provider.file = File(image.path);
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),                  child: TextField(
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
                        if (provider.file != null) SizedBox(width: width * 0.1),
                        if (provider.file != null)
                          IconButton(
                              onPressed: () => provider.deleteImage(),
                              icon: Icon(Icons.delete, color: Colors.red)),
                      ],
                    )),
                provider.file == null
                    ? SizedBox(height: 20)
                    : Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.28),
                  height: height * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(
                      File(provider.file!.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                if (provider.file==null && provider.tempFile!=null && provider.tempFile!='')
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                    height: height * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: provider.tempFile,
                        placeholder: (context, url) => const Center(
                            child:
                            const CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
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
                              _description.text, 'shawarma', provider.tabIndex);
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

    Future pickImage(ImageSource src) async {
      try {
        var image = (await ImagePicker().pickImage(source: src));
        if (image == null) return;
        setState(() {
          provider.file = File(image.path);
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
                      const SizedBox(
                          width: 10
                      ),
                      Text(lanProvider.texts('add image')),
                      if (provider.file != null) SizedBox(width: width * 0.1),
                      if (provider.file != null)
                        IconButton(
                            onPressed: () => provider.deleteImage(),
                            icon: Icon(Icons.delete, color: Colors.red)),
                    ],
                  )),
              provider.file == null
                  ? SizedBox(height: 20)
                  : Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                height: height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    File(provider.file!.path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              if (provider.isLoading)
                Center(child: const CircularProgressIndicator()),
              if (!provider.isLoading)
                Center(
                  child: Text(
                    lanProvider.texts('add text'),
                    style: TextStyle(fontSize: width * 0.037),
                  ),
                ),
              const SizedBox(height: 10),
              if (!provider.isLoading)
                Container(
                  height: height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: width*0.2),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_mealName.text.isEmpty || _price.text.isEmpty)
                          return dialog(lanProvider.texts('empty field'));
                        setState(() {
                          provider.isLoading = true;
                        });
                        await provider.addMeal(_mealName.text, _price.text,
                            _description.text, 'shawarma', "shawarma");
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
                      lanProvider.texts('tab1'),
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (!provider.isLoading)
                Container(
                  height: height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: width*0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            provider.isLoading = true;
                          });
                          await provider.addMeal(_mealName.text, _price.text,
                              _description.text, 'shawarma', "snacks");
                          Navigator.of(context).pop();
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
                        lanProvider.texts('tab2'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              const SizedBox(height: 20),
              if (!provider.isLoading)
                Container(
                  height: height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: width*0.2),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            provider.isLoading = true;
                          });
                          await provider.addMeal(_mealName.text, _price.text,
                              _description.text, 'shawarma', "others");
                          Navigator.of(context).pop();
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
        stream: FirebaseFirestore.instance
            .collection('/shawarma/${provider.authData['name']}/shawarma')
            .snapshots(),
        builder: (ctx, snapshot) {
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
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
                                        provider.mealID = resData[index].id;
                                        provider.tempFile = resData[index]['imageUrl'];
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
                                                      await provider.deleteMeal(
                                                          "shawarma", 'shawarma');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
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
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        provider.isLoading = false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!provider.isLoading)
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
        stream: FirebaseFirestore.instance
            .collection('/shawarma/${provider.authData['name']}/snacks')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
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
                                        provider.mealID = resData[index].id;
                                        provider.tempFile = resData[index]['imageUrl'];
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
                                              style: const TextStyle(fontSize: 23),
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
                                                      await provider.deleteMeal(
                                                          "shawarma", 'snacks');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
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
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        provider.isLoading = false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!provider.isLoading)
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
        stream: FirebaseFirestore.instance
            .collection('/shawarma/${provider.authData['name']}/others')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: const CircularProgressIndicator());
          return Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length??0,
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
                                        provider.mealID = resData[index].id;
                                        provider.tempFile = resData[index]['imageUrl'];
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
                                              style: const TextStyle(fontSize: 23),
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
                                                      await provider.deleteMeal(
                                                          "shawarma", 'others');
                                                      Fluttertoast.showToast(
                                                          msg: lanProvider.texts(
                                                              'Meal Deleted'),
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
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                      print(e.message);
                                                    } catch (e) {
                                                      setState(() {
                                                        provider.isLoading = false;
                                                      });
                                                      print(e);
                                                      dialog(lanProvider.texts(
                                                          'Error occurred !'));
                                                    }
                                                  },
                                                ),
                                              const SizedBox(width: 11),
                                              if (!provider.isLoading)
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
