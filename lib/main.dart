import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/patrimonio_controller.dart';
import 'views/home_view.dart';

void main() {

  runApp(
    const MeuAplicativo(),
  );
}

class MeuAplicativo extends StatelessWidget {

  const MeuAplicativo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    // Registra o controller
    Get.put(
      PatrimonioController(),
    );

    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Patrimônios SENAI',

      theme: ThemeData(

        useMaterial3: true,

        colorScheme:
            ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),

        inputDecorationTheme:
            const InputDecorationTheme(
          floatingLabelBehavior:
              FloatingLabelBehavior.auto,
        ),
      ),

      home: HomeView(),
    );
  }
}