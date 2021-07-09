import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lets_talk_money/signIn.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Friendly Chat',
        theme: ThemeData(
            primarySwatch: Colors.pink),
        home: SignIn()
    );
  }
}