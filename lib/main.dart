import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/provider.dart';
import 'package:restaurants_panel/res_admin.dart';
import 'package:restaurants_panel/settings.dart';
import 'package:restaurants_panel/shawarma_admin.dart';
import 'package:restaurants_panel/sweet_admin.dart';
import 'package:restaurants_panel/userState.dart';
import 'drinks_admin.dart';
import 'provider.dart';
import 'homos_admin.dart';
import 'languageProvider.dart';
import 'logIn.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MyProvider>(create: (_) => MyProvider()),
      ChangeNotifierProvider<LanProvider>(create: (_) => LanProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    Provider.of<LanProvider>(context, listen: false).getLanguage();
    Provider.of<MyProvider>(context, listen: false).fetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserState(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.white,
        floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.blue), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orangeAccent),
      ),
      routes: {
        'myApp': (context) => MyApp(),
        'login': (context) => Login(),
        'adminShawarma': (context) => AdminShawarma(),
        'adminHomos': (context) => AdminHomos(),
        'adminSweets': (context) => AdminSweets(),
        'adminDrinks': (context) => AdminDrinks(),
        'adminRes': (context) => AdminRes(),
        'editShawarma': (context) => EditShawarma(),
        'editSweets': (context) => EditSweets(),
        'editHomos': (context) => EditHomos(),
        'editDrinks': (context) => EditDrinks(),
        'editRes': (context) => EditRes(),
        'addMeal': (context) => AddMealShawarma(),
        'addMealSweets': (context) => AddMealSweets(),
        'addMealHomos': (context) => AddMealHomos(),
        'addMealDrinks': (context) => AddMealDrinks(),
        'addMealRes': (context) => AddMealRes(),
        'userState': (context) => UserState(),
        'settings':(context) => SettingsScreen(),
      },
    );
  }
}
