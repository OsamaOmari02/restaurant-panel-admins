import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/provider.dart';
import 'package:restaurants_panel/shawarma_admin.dart';
import 'package:restaurants_panel/sweet_admin.dart';
import 'package:restaurants_panel/userState.dart';

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
    Provider.of<MyProvider>(context, listen: false).getDarkMode();
    Provider.of<MyProvider>(context,listen: false).getAdmin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.orangeAccent),
        brightness: Brightness.light,
        canvasColor: Colors.white,
        accentColor: Colors.orangeAccent,
        floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.blue),
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      routes: {
        'login': (context) => Login(),
        'admin': (context) => Admin(),
        'editShawarma': (context) => Edit(),
        'editSweets': (context) => EditSweets(),
        'editHomos': (context) => EditHomos(),
        'addMeal': (context) => AddMeal(),
        'addMealSweets': (context) => AddMealSweets(),
        'addMealHomos': (context) => AddMealHomos(),
        'userState': (context) => UserState(),
        'adminHomos': (context) => AdminHomos(),
        'adminSweets': (context) => AdminSweets(),
      },
    );
  }
}
