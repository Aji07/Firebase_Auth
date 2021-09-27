import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'home_page.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref=await SharedPreferences.getInstance();
  //var Email=pref.getString('email');
  var CurrentUser=FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    home:CurrentUser == null ? Login_Page() : Home_Page(),
  ));
  }
