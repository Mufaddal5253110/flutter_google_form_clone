import 'package:flutter/material.dart';
import 'package:google_form_clone/Screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Google Form',
        theme: ThemeData(
          canvasColor: Colors.purple.shade50,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(
              color: Colors.black54,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey[600],
          ),
        ),
        home: const HomePage());
  }
}
