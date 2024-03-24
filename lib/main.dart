import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_2/home/home_screen.dart';
import 'package:todo_app_2/provider/app_config_provider.dart';
import 'package:todo_app_2/provider/auth_provider.dart';
import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';
import 'my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//FAHD

void main() async {
  // Hello
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: CustomFirebaseOptions.androidOptions);
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.enableNetwork();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListProvider()),
        ChangeNotifierProvider(create: (context)=> AuthProviders()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: RegisterScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),

      },
    );
  }
}
