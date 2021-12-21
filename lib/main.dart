import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_panel/mo3ajanat.dart';
import 'package:restaurants_panel/pizza_admin.dart';
import 'package:restaurants_panel/res_admin.dart';
import 'package:restaurants_panel/rice_admin.dart';
import 'package:restaurants_panel/settings.dart';
import 'package:restaurants_panel/shawarma_admin.dart';
import 'package:restaurants_panel/sweet_admin.dart';
import 'package:restaurants_panel/userState.dart';
import 'details.dart';
import 'drinks_admin.dart';
import 'orders.dart';
import 'provider.dart';
import 'homos_admin.dart';
import 'languageProvider.dart';
import 'logIn.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
        'orders': (context) => Orders(),
        'details': (context) => Details(),
        'login': (context) => Login(),
        'adminShawarma': (context) => AdminShawarma(),
        'adminHomos': (context) => AdminHomos(),
        'adminSweets': (context) => AdminSweets(),
        'adminDrinks': (context) => AdminDrinks(),
        'adminRes': (context) => AdminRes(),
        'adminPizza': (context) => AdminPizza(),
        'adminRice': (context) => AdminRice(),
        'adminMo3ajanat': (context) => AdminMo3ajanat(),
        'editShawarma': (context) => EditShawarma(),
        'editSweets': (context) => EditSweets(),
        'editHomos': (context) => EditHomos(),
        'editDrinks': (context) => EditDrinks(),
        'editRes': (context) => EditRes(),
        'editPizza': (context) => EditPizza(),
        'editRice': (context) => EditRice(),
        'editMo3ajanat': (context) => EditMo3ajanat(),
        'addMeal': (context) => AddMealShawarma(),
        'addMealSweets': (context) => AddMealSweets(),
        'addMealHomos': (context) => AddMealHomos(),
        'addMealDrinks': (context) => AddMealDrinks(),
        'addMealRes': (context) => AddMealRes(),
        'addMealPizza': (context) => AddMealPizza(),
        'addMealRice': (context) => AddMealRice(),
        'addMealMo3ajanat': (context) => AddMealMo3ajanat(),
        'userState': (context) => UserState(),
        'settings':(context) => SettingsScreen(),
      },
    );
  }
}
