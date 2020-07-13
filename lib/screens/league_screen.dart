import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_sports_db/constants.dart';
import 'package:http/http.dart' as http;

class LeagueScreen extends StatefulWidget {
  LeagueScreen({this.countryName});
  final String countryName;

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  String searchString='';
  final _searchFieldController=TextEditingController();
  bool _loading=true;
  Map leagueDetails;
  List<LeagueDetailsCard> leagueCards = [];
  @override
  void initState() {
    getAllLeagues();
    super.initState();
  }
  void getAllLeagues(){
    http.get('https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=${widget.countryName}')
    .then((value) => setState((){leagueDetails=jsonDecode(value.body);_loading=false;},),);
  }
  void searchLeagues(String searchString)
  {
    http.get('https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=$searchString&c=${widget.countryName}').then((value) => setState((){leagueDetails=jsonDecode(value.body);_loading=false;},),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'images/arrow_left.svg',
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          widget.countryName,
          style: TextStyle(fontSize: 23),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      onChanged: (value) {
                        searchString = value;
                      },
                      onSubmitted: (value) {
                        setState(() {
                          _loading = true;
                          searchLeagues(value);
                        });
                      },
                      textInputAction: TextInputAction.search,
                      cursorColor: kPrimaryColor,
                      controller: _searchFieldController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Search Leagues...',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      _searchFieldController.clear();
                      setState(() {
                        _loading=true;
                        getAllLeagues();
                      });
                    },
                    child: Text('clear',style: TextStyle(color:kPrimaryColor),),),
                )
              ],
            ),
          ),
          Expanded(
            child: _loading?Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),),):ListView(
              children: <Widget>[
      for (Map league in leagueDetails['countrys'])
        LeagueDetailsCard(
          leagueName: league['strLeague'],
          leagueLogo: league['strLogo'],
          twitterLink: league['strTwitter'],
          facebookLink: league['strFacebook'],
          sportName: league['strSport'],
        )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class LeagueDetailsCard extends StatelessWidget {
  LeagueDetailsCard({this.leagueName,this.leagueLogo,this.twitterLink,this.facebookLink,this.sportName});
  final String leagueName,leagueLogo,twitterLink,facebookLink,sportName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              "https://www.thesportsdb.com/images/sports/${sportName.toLowerCase().split(' ').join('_')}.jpg"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              leagueName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: 80,
                    height: 80,
                    child: leagueLogo!=null?Image.network(
                      leagueLogo,
                    ):Container(),),),
            Row(
              children: <Widget>[
                twitterLink!=""?
                SvgPicture.asset(
                  'images/twitter.svg',
                  height: 26,
                  width: 26,
                  color: Colors.white,
                ):Container(),
                SizedBox(width: 20),
                facebookLink!=""?
                SvgPicture.asset(
                  'images/facebook.svg',
                  height: 26,
                  width: 26,
                  color: Colors.white,
                ):Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}