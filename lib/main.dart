
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/patrimonio_controller.dart';
import 'views/patrimonio_page.dart';

void main() {
  Get.put(PatrimonioController());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patrimônios SENAI',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF205988),
        ),
        useMaterial3: true,
      ),

      home: PatrimonioPage(),
    ),
  );
}