import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum authStatus { Authenticating, unAuthenticated, Authenticated }

class Meals {
  final String id;
  var mealName;
  var mealPrice;
  var description;
  final String resName;

  Meals(
      {required this.resName,
        required this.description,
        required this.mealName,
        required this.mealPrice,
        required this.id});
}

class MyProvider with ChangeNotifier {

  //-----------------------things----------------------------
  bool admin = false;
  setAdmin(val) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('admin', val);
    notifyListeners();
  }
  getAdmin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    admin = pref.getBool('admin')!;
    notifyListeners();
  }
  bool isLoading = false;
  List<Meals> mealIDs = [];
  var mealID;


  //-----------------------admin----------------------------
  String tabIndex = "";

  Future<void> fetchMealsShawarma(title) async {
    await FirebaseFirestore.instance
        .collection('shawarma/$title/shawarma')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              resName: title,
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id));
      });
    });
    await FirebaseFirestore.instance
        .collection('shawarma/$title/snacks')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    await FirebaseFirestore.instance
        .collection('shawarma/$title/others')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsHomos(title) async {
    await FirebaseFirestore.instance
        .collection('homos/$title/meals')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsSweets(title) async {
    await FirebaseFirestore.instance
        .collection('sweets/$title/kunafeh')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    await FirebaseFirestore.instance
        .collection('sweets/$title/cake')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    await FirebaseFirestore.instance
        .collection('sweets/$title/others')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> addMeal(
      String mealName, String price, String desc, type, tab) async {
    isLoading = true;
    var uuid = Uuid().v4();
    await FirebaseFirestore.instance
        .collection('$type/${authData['name']}/$tab')
        .doc(uuid)
        .set({
      'meal name': mealName,
      'meal price': price,
      'description': desc,
      'resName': authData['name'],
    }).then((value) {
      mealIDs.add(Meals(
          id: uuid,
          mealPrice: price,
          mealName: mealName,
          description: desc,
          resName: authData['name']!));
    });
    notifyListeners();
  }

  deleteMeal(type, tab) async {
    isLoading = true;
    final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
    await FirebaseFirestore.instance
        .collection('$type/${authData['name']}/$tab')
        .doc(mealID)
        .delete()
        .then((value) {
      mealIDs.removeAt(mealIndex);
    });
    notifyListeners();
  }

  editMeal(String mealName, price, String desc, type, tab) async {
    isLoading = true;
    final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
    await FirebaseFirestore.instance
        .collection('$type/${authData['name']}/$tab')
        .doc(mealID)
        .update({
      'meal name': mealName,
      'meal price': price,
      'description': desc,
    }).then((value) {
      mealIDs[mealIndex].mealName = mealName;
      mealIDs[mealIndex].mealPrice = price;
      mealIDs[mealIndex].description = desc;
    });
    notifyListeners();
  }

  //------------------------auth----------------------
  authStatus authState = authStatus.Authenticated;
  Map<String, String> authData = {
    'email': ' ',
    'password': ' ',
    'name': ' ',
    'type':' ',
  };

  fetch() async {
    final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(user!.uid)
          .get()
          .then((val) {
        authData['email'] = val.data()!['email'];
        authData['password'] = val.data()!['password'];
        authData['name'] = val.data()!['name'];
        authData['type'] = val.data()!['type'];
        notifyListeners();
      });
  }

}
