import 'package:flutter/material.dart';
import 'package:the_sports_db/components/country_button.dart';
import 'package:the_sports_db/constants.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'The Sports DB',
                style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Column(children: <Widget>[
                CountryButton(
                  countryName: 'India',
                ),
                CountryButton(
                  countryName: 'United States',
                ),
                CountryButton(
                  countryName: 'Australia',
                ),
                CountryButton(
                  countryName: 'China',
                ),
                CountryButton(
                  countryName: 'Argentina',
                ),
                CountryButton(
                  countryName: 'Canada',
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

