import 'package:flutter/material.dart';
import 'package:the_sports_db/constants.dart';
import 'package:the_sports_db/screens/landing_screen.dart';

void main() {
  runApp(TheSportsDb());
}

class TheSportsDb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          color: kPrimaryColor,
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white),
          ),
        ),
      ),
      home: LandingScreen(),
    );
  }
}
