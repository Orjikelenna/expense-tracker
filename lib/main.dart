import 'package:flutter/material.dart';
//import 'screens/home_screen.dart';
import 'screens/main_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 3, 204, 120)),
      useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const MainScreen(),

    );
  }
}
