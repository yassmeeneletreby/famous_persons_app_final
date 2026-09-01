import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FamousPersonsApp());
}

class FamousPersonsApp extends StatelessWidget {
  const FamousPersonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Famous Persons',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
