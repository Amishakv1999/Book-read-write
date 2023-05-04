import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:read_write/homeScreen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        )
    ),
    home: AddBookScreen(),
  ),);
}

