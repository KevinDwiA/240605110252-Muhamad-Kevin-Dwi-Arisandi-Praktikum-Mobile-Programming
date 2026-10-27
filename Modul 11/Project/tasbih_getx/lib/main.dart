import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/home.dart';
import 'viewmodel/tasbih_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Langkah e: GetMaterialApp sebagai akar aplikasi GetX.
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasbih Digital GetX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(TasbihController());
      }),
      home: const Home(),
    );
  }
}
