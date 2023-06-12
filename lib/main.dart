import 'package:flutter/material.dart';
import 'package:lora_app/Login%20&%20Signup/LoginPage.dart';

import 'package:lora_app/mobile/home_page_mobile.dart';

// ignore: unused_import
import 'package:lora_app/web/home_page_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth > 800){
            /* return homePageWeb(nombre: "", userRole: "",); */
            return LoginPage();
          }
          else {
            return homePageMobile();
          }
        },
      ),
    );
  }
}

