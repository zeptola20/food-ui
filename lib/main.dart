import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ui1/controllers/themes/custon-theme.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:food_ui1/bindings/my_bindings.dart';
import 'package:food_ui1/screen/details_screen.dart';
import 'package:food_ui1/screen/home_screen.dart';
import 'package:food_ui1/screen/logged-in-screen.dart';
import 'package:food_ui1/screen/sign-in-google.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    customThemeProvidr.addListener(() {
      setState(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home_screen',
      initialBinding: MyBindings(),
      getPages: [
        GetPage(name: '/details_screen', page: () => DetailsScreen()),
        GetPage(name: '/home_screen', page: () => HomeScreen()),
        GetPage(name: '/google_login_screen', page: () => LoggedInScreen()),
        GetPage(
            name: '/google_signin_screen', page: () => GoogleSignInScreen()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CustomThemeProvidr.lightTheme,
      darkTheme: CustomThemeProvidr.darkTheme,
      themeMode: customThemeProvidr.currentTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!'),
            );
          } else if (snapshot.hasData) {
            return const LoggedInScreen();
          }
          return const GoogleSignInScreen();
        },
      ),
    );
  }
}
