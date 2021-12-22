import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum authStatus { Authenticating, unAuthenticated, Authenticated }

class Meals {
  final String id;
  var mealName;
  var mealPrice;
  var description;
  final String resName;
  String imageUrl='';

  Meals(
      {required this.resName,
        required this.description,
        required this.mealName,
        required this.mealPrice,
        imageUrl,
        required this.id,});
}
class FoodCart {
  var mealName;
  var mealPrice;
  var description;
  var quantity;

  FoodCart(
      {required this.description,
        required this.mealName,
        required this.mealPrice,
        required this.quantity});
}

class MyProvider with ChangeNotifier {

  //-----------------------things----------------------------
  // bool admin = false;
  // setAdmin(val) async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setBool('admin', val);
  //   notifyListeners();
  // }
  // getAdmin() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   admin = pref.getBool('admin')!;
  //   notifyListeners();
  // }
  var mealNameCont;
  var mealPriceCont;
  var mealDescCont;

  Map<String, String> details = {
    'name': '',
    'total': '',
    'note': '',
    'length':'',
  };

  List<FoodCart> detailedCart = [];

  bool isLoading = false;
  List<Meals> mealIDs = [];
  var mealID;

  String dateTime(timeStamp) {
    var time = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy    hh:mm a').format(time);
  }


  //-----------------------admin----------------------------
  String tabIndex = "";

  Future<void> fetchMealsShawarma(title) async {
    if (authData['name'] != 'Snap Burger' && authData['name'] != 'شاورما هنية')
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
    if (authData['name'] == 'الدويري') {
      await FirebaseFirestore.instance
          .collection('shawarma/$title/Chicken')
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
          .collection('shawarma/$title/Aldwairy')
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
          .collection('shawarma/$title/BreakFast')
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
    }
    if (authData['name'] == 'هون وبس') {
      await FirebaseFirestore.instance
          .collection('shawarma/$title/Falafel')
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
          .collection('shawarma/$title/Mo3ajanat')
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
          .collection('shawarma/$title/Hummus')
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
    }
    if (authData['name'] != 'شاورما هنية' &&
        authData['name'] != 'الدويري' &&
        authData['name'] != 'هون وبس')
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

  Future<void> fetchMealsDrinks(title) async {
    if (authData['name'] != 'الحفرة' && authData['name'] != 'لبناني الشمال')
      await FirebaseFirestore.instance
          .collection('drinks/$title/meals')
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
    else if (authData['name'] == 'الحفرة') {
      await FirebaseFirestore.instance
          .collection('drinks/$title/milk')
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
          .collection('drinks/$title/mixes')
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
          .collection('drinks/$title/hot drinks')
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
    } else if (authData['name'] == 'لبناني الشمال') {
      await FirebaseFirestore.instance
          .collection('drinks/$title/milk')
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
          .collection('drinks/$title/natural cocktail')
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
          .collection('drinks/$title/natural drinks')
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
          .collection('drinks/$title/special cocktail')
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
          .collection('drinks/$title/natural slush')
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
          .collection('drinks/$title/fruits salads')
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
          .collection('drinks/$title/waffle')
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
    }
    notifyListeners();
  }
  Future<void> fetchMealsMain(title) async {
    await FirebaseFirestore.instance
        .collection('mainRes/$title/meals')
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

  Future<void> fetchMealsPizza(title) async {
    await FirebaseFirestore.instance
        .collection('Pizza/$title/Pizza')
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
    if (title == 'بيتزا المفرق')
      await FirebaseFirestore.instance
          .collection('Pizza/$title/broasted')
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
        .collection('Pizza/$title/others')
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

  Future<void> fetchMealsMo3ajanat(title) async {
    if (authData['name'] == 'معجنات ورد') {
      await FirebaseFirestore.instance
          .collection('mainRes/$title/manakeesh')
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
    }
    await FirebaseFirestore.instance
        .collection('mainRes/$title/Pizza')
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
    if (authData['name'] == 'ارزه لبنان')
      await FirebaseFirestore.instance
          .collection('mainRes/$title/mashrouh')
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
        .collection('mainRes/$title/others')
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

  Future<void> fetchMealsRice(title) async {
    await FirebaseFirestore.instance
        .collection('rice/$title/riceTypes')
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
        .collection('rice/$title/rice')
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
        .collection('rice/$title/others')
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
    if (authData['name'] == 'نفيسة' || authData['name'] == 'الصالون الأخضر-شويكة')
      await FirebaseFirestore.instance
          .collection('sweets/$title/gateau')
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
    if (authData['name'] == 'الصالون الأخضر-شويكة') {
      await FirebaseFirestore.instance
          .collection('sweets/$title/snacks')
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
          .collection('sweets/$title/pizza')
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
          .collection('sweets/$title/rolls')
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
          .collection('sweets/$title/waffle')
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
          .collection('sweets/$title/ice cream')
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
    }
    if (authData['name'] != 'الصالون الأخضر-شويكة')
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


  var file;
  var imageUrl;
  var tempFile;
  Future<void> addMeal(
      String mealName, String price, String desc, type, tab) async {
    isLoading = true;
    var uuid = Uuid().v4();
    if (file!=null) {
      await FirebaseStorage.instance.ref().child(uuid)
          .child('imageName').putFile(file).then((value) async {
        imageUrl = await value.ref.getDownloadURL();
      });
    }
    await FirebaseFirestore.instance
        .collection('$type/${authData['name']}/$tab')
        .doc(uuid)
        .set({
      'meal name': mealName,
      'meal price': price,
      'description': desc,
      'resName': authData['name'],
      'imagePath':file==null?'':Uri.file(file.path).pathSegments.last,
      'imageUrl':file==null?'':imageUrl??'',
    }).then((value) {
      mealIDs.add(Meals(
          id: uuid,
          mealPrice: price,
          mealName: mealName,
          description: desc,
          imageUrl:file==null?'':imageUrl??'',
          resName: authData['name']!));
    });
    file = null;
    imageUrl = null;
    notifyListeners();
  }

  deleteImage() async{
    file = null;
    tempFile = null;
    notifyListeners();
  }

  deleteMeal(type, tab) async {
    isLoading = true;
    final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
    if (tempFile!=null) {
      await FirebaseStorage.instance.refFromURL(tempFile)
          .delete();
    }
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
    if (file!=null)
      await FirebaseStorage.instance.ref().child(mealIDs[mealIndex].id).
      child('imageName').putFile(file).then((value) async{
      imageUrl = await value.ref.getDownloadURL();
    });
    await FirebaseFirestore.instance
        .collection('$type/${authData['name']}/$tab')
        .doc(mealID)
        .update({
        'meal name': mealName,
        'meal price': price,
      if (desc!='')
        'description': desc,
      if (file!=null)
        'imagePath':Uri.file(file.path).pathSegments.last,
      if (file!=null)
        'imageUrl': imageUrl??'',
    }).then((value) {
        mealIDs[mealIndex].mealName = mealName;
        mealIDs[mealIndex].mealPrice = price;
      if (desc!='')
       mealIDs[mealIndex].description = desc;
      if (file!=null)
        mealIDs[mealIndex].imageUrl = imageUrl??'';
    });
    file = null;
    imageUrl = null;
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
          .doc(user?.uid)
          .get()
          .then((val) {
        authData['email'] = val.data()?['email']??"";
        authData['password'] = val.data()?['password']??"";
        authData['name'] = val.data()?['name']??"";
        authData['type'] = val.data()?['type']??"";
        notifyListeners();
      });
  }


}
