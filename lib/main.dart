



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth/regist/registeration_tap.dart';
import 'package:to_do_list/home/home_screen.dart';
import 'package:to_do_list/login_screen.dart';
import 'package:to_do_list/my_theme.dart';
import 'package:to_do_list/provider/auth_provider.dart';
import 'package:to_do_list/provider/provider.dart';

import 'firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  // await FirebaseFirestore.instance.disableNetwork();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=> ListProvider()),
    ChangeNotifierProvider(create: (context)=> AuthProviders())
  ],
  child: MyApp(),));
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginTap.routeName ,
      routes: {
        HomeScreen.routeName :(context) => HomeScreen(),
        RegisterTap.routeName : (context) => RegisterTap(),
        LoginTap.routeName : (context) => LoginTap(),


      },
      theme: MyTheme.lightTheme,
    );
  }
}