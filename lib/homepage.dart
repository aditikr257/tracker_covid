import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:tracker_covid/datasorce.dart';
import 'package:tracker_covid/pages/countyPage.dart';
import 'package:tracker_covid/panels/infoPanel.dart';
import 'package:tracker_covid/panels/mosteffectedcountries.dart';
import 'package:tracker_covid/panels/worldwidepanel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
        centerTitle: false,
        title: Text(
          'COVID-19 TRACKING APP',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0)),
                  image: DecorationImage(
                      image: AssetImage('assets/front.jpg'),
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.2),
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Don't worry 'bout a thing, cause every little thing's gonna be alright.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Worldwide',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Regional',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            worldData == null
                ? CircularProgressIndicator()
                : WorldwidePanel(
                    worldData: worldData,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Most affected Countries',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            countryData == null
                ? Container()
                : MostAffectedPanel(
                    countryData: countryData,
                  ),
            InfoPanel(),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'PREQUATIONS TO BE TAKEN ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 180,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0)),
                  image: DecorationImage(
                      image: AssetImage('assets/prec.jpg'), fit: BoxFit.fill)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.2),
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Don't worry!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Read More',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontFamily: 'PatuaOne')),
                color: Colors.indigoAccent.shade200,
                hoverColor: Colors.orange,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TwelthPage(data: 'Who I am ?'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'BE PRODUCTIVE! ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 180,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0)),
                  image: DecorationImage(
                      image: AssetImage('assets/pro.jpg'), fit: BoxFit.fill)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.2),
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Let's Do It!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Read More',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontFamily: 'PatuaOne')),
                color: Colors.indigoAccent.shade200,
                hoverColor: Colors.orange,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ThirteenthPage(data: 'Who I am ?'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}

class TwelthPage extends StatelessWidget {
  final String data;

  TwelthPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        margin: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Precautions',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'SourceSerifPro',
                      wordSpacing: 3.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/wash.jpg'),
                        fit: BoxFit.fill)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Wash your Hands Regularly",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSerifPro',
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'There is no cure for COVID-19 yet. '
                  'But the best way to counter the disease for now is to'
                  ' wash your hands with soap regularly. Wash hands before '
                  'eating, after sneezing, or coughing, and after coming in '
                  'contact with someone who shows symptoms. Washing your '
                  'hands properly can help you stay disease-free.',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'SourceSerifPro',
                      wordSpacing: 3.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 180,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/sd.jpg'), fit: BoxFit.fill)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Social Distancing",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSerifPro',
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'It is difficult to identify who is infected and who isn’t,'
                  ' so avoid close contact with people around you. If someone '
                  'around you is coughing or sneezing, try to maintain a distance of'
                  ' 1 meter and cover your mouth and eyes. Since the disease spreads'
                  ' from person to person through the liquid droplets that are sprayed '
                  'when someone sneezes or coughs, doing this can prevent the virus from '
                  'entering your body.',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'SourceSerifPro',
                      wordSpacing: 3.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 180,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/si.png'), fit: BoxFit.fill)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Stay Informed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSerifPro',
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'Keep a check on Coronavirus updates in your locality.'
                  ' Avoid parts of the city that have confirmed cases of the'
                  ' disease. Gather information through reliable sources like the'
                  ' World Health Organization (and not WhatsApp videos) about current'
                  ' prevention methods that have been put in place and follow them.'
                  ' National and local authorities have the most up-to-date'
                  ' information on the situation in your locality.',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'SourceSerifPro',
                      wordSpacing: 3.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 180,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/san.jpg'), fit: BoxFit.fill)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Sanitize your hands",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSerifPro',
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'Alcoholic hand rubs or sanitizers are the most convenient hygiene measure you can take. It is an effective '
                  'and practical way to keep your hands clean in public places without getting your '
                  'hands wet. Buy sanitizers that contain 60 to 95% alcohol.',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'SourceSerifPro',
                      wordSpacing: 3.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 180,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/mask.png'),
                        fit: BoxFit.fill)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Use a Facemask",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSerifPro',
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'If you live in a region that has reported cases of COVID-19, '
                  'consider wearing a Facemask before heading out. A face'
                  ' mask gives you basic protection against airborne germs and'
                  ' infections. Especially in crowded places and public transport,'
                  ' a Facemask is a necessary step whether you are showing symptoms or not.',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'SourceSerifPro',
                      wordSpacing: 3.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 180,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/download.jpg'),
                        fit: BoxFit.fill)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Eat healthy Food!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSerifPro',
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "Have separate cutting boards for meat and vegetables and "
                  "clean them regularly with soap. Wash your hands after handling raw food"
                  " and before consuming cooked food. Do not eat food from restaurants or "
                  "stalls that don't have basic hygiene facilities like hand wash or sanitizer."
                  " Only consume meat products that have been thoroughly cooked because the heat "
                  "kills the germs that may be present",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'SourceSerifPro',
                      wordSpacing: 3.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThirteenthPage extends StatelessWidget {
  final String data;

  ThirteenthPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        margin: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'How to be Productive?',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'SourceSerifPro',
                      wordSpacing: 3.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      image: DecorationImage(
                          image: AssetImage('assets/fam.jpg'),
                          fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Spend Time with your family!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSerifPro',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),

                back: Container(
                  child: Center(
                    child: Text('To spend quality time with your family should be'
                        ' your priority because one of the many things this lockdown '
                        'has made us realise is that it is only our family who is going to stay '
                        'with us forever, all the rest is either distant or temporary.',
                        style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSerifPro',
                        fontSize: 17.0),
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      image: DecorationImage(
                          image: AssetImage('assets/book.jpg'),
                          fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Read Motivational Books!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSerifPro',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),

                back: Container(
                  child: Center(
                    child: Text('One of the best ways to improve focus and concentration is to pick up a book and spend some time reading for pleasure.Books exercise the brain, build our vocabularies, lowers stress and also enhances the imagination. Whether you prefer fiction or non-fiction, buy yourself some books and start reading more this week.',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 17.0),
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      image: DecorationImage(
                          image: AssetImage('assets/art.webp'),
                          fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "GET ARTISTIC!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSerifPro',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),

                back: Container(
                  child: Center(
                    child: Text('DIY and gardening not quite right for you, but you’d like to do something creative? Art and crafts is a great way to express yourself, learn a new skill, and help you see ordinary things in a whole new way and channel your creativity. You can paint canvasses, doodle in a sketchpad or draw in adult colouring books. Go a step further in this respect and take up knitting, candle-making and jewellery-making. ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 17.0),
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      image: DecorationImage(
                          image: AssetImage('assets/learn.jpg'),
                          fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "LEARN A NEW LANGUAGE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSerifPro',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),

                back: Container(
                  child: Center(
                    child: Text('How many times have you said that you’d like to learn a new language? I’m sure you have many times over the years. Well, now you have time to do so. With apps like Memrise and Duolingo, you can do so easily and at no cost.',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 17.0),
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      image: DecorationImage(
                          image: AssetImage('assets/work.jpg'),
                          fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "SET A WORKOUT ROUTINE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSerifPro',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),

                back: Container(
                  child: Center(
                    child: Text('How long have we all been looking to begin this activity? If you work out regularly, you will know that the key to a successful and consistent workout regime is routine. And I don’t need to tell you about the benefits of working out and keeping fit.',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 17.0),
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      image: DecorationImage(
                          image: AssetImage('assets/blog.png'),
                          fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "KEEP A BLOG/JOURNAL !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSerifPro',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),

                back: Container(
                  child: Center(
                    child: Text('Keeping track of your thoughts, activities and learnings is always a good idea - and a highly productive one at that. You might look back at this time and process your memories or even process your thoughts for the day or the week that has passed. You can do this privately on your computer, mobile or even better in a notebook. ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 17.0),
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      image: DecorationImage(
                          image: AssetImage('assets/devlop.jpg'),
                          fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Create Personal Development Plan!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSerifPro',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),

                back: Container(
                  child: Center(
                    child: Text('Much of the above focus on non-professional and work-related activities that you can do, and still be productive. However, from a long-term perspective, it makes sense to also work on your professional capabilities and skills that you can offer your employer and future employers.',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSerifPro',
                          fontSize: 17.0),
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text("LET'S GET TOGETHER ANF FEEL ALLRIGHT!"),
            ],
          ),
        ),
      ),
    );
  }
}
