import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'widgets/components.dart';

void main() => runApp(const RasaApp());
class RasaApp extends StatelessWidget {
  const RasaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false, title: 'Rasa',
    theme: ThemeData(useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: accent),
      scaffoldBackgroundColor: const Color(0xFFFFFAF3),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFAF3),
        foregroundColor: ink, centerTitle: false),
      inputDecorationTheme: InputDecorationTheme(filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)))),
    home: const HomeScreen());
}
