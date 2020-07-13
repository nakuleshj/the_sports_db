import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_sports_db/screens/league_screen.dart';

class CountryButton extends StatelessWidget {
  CountryButton({this.countryName});
  final String countryName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LeagueScreen(countryName: countryName,),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.red[200],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                countryName,
                style: TextStyle(fontSize: 22),
              ),
              SvgPicture.asset(
                'images/arrow_right.svg',
                height: 30,
                width: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
