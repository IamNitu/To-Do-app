

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/screens/util/login_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
   );
  }
}