import 'package:coba_uas/pages/login_page.dart';
import 'package:coba_uas/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

void main() {
  Get.put(ApiService()); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      debugShowCheckedModeBanner: false,
      title: 'Bengkel Jaya Makmur',
      theme: ThemeData(
        primarySwatch: Colors.pink, 
      ),
      home: LoginScreen(),
    );
  }
}
