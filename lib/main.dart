import 'package:flutter/material.dart';
import 'package:flutter_edmt_quiz_app/screens/calender.dart';
import 'package:flutter_edmt_quiz_app/screens/home_page.dart';
import 'package:flutter_edmt_quiz_app/screens/question_detail.dart';
import 'package:flutter_edmt_quiz_app/screens/read_mode.dart';
import 'package:flutter_edmt_quiz_app/screens/show_result.dart';
import 'package:flutter_edmt_quiz_app/screens/subject.dart';
import 'package:flutter_edmt_quiz_app/screens/test_mode.dart';
import 'package:flutter_riverpod/all.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      routes: {
        "/homePage": (context) => MyCategoryPage(
              title: 'KPR Learn',
            ),
        "/readMode": (context) => MyReadModePage(),
        "/testMode": (context) => MyTestModePage(),
        "/showResult": (context) => MyResultPage(),
        "/questionDetail": (context) => MyQuestionDetailPage(),
        "/subjectDetail": (context) => subjectPage(),
        "/calenderPage": (context) => HomeCalendarPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'EDMT Quiz App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //@override
  //void initState() {
  // TODO: implement initState
  // super.initState();
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //  Navigator.of(context).pop();
  //  Navigator.pushNamed(context, "/homePage");
  //});
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Ace your",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        height: 1.2),
                  ),
                ),
                Container(
                  child: Text(
                    "Engineering",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w500,
                        height: 1.2),
                  ),
                ),
                Container(
                  child: Text(
                    "Dream!..",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        height: 1.2),
                  ),
                ),
                // Container(
                //   child: Text(
                //     "",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 40,
                //         fontWeight: FontWeight.w500,
                //         height: 1),
                //   ),
                // ),
                // Container(
                //   child: Text(
                //     "",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 40,
                //         fontWeight: FontWeight.w900,
                //         height: 1),
                //   ),
                // ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/splash.png'),
                        fit: BoxFit.fitWidth)),
              ),
              Positioned(
                bottom: 90,
                left: 0,
                right: 0,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      openMainPage();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: Text(
                        'Continue..',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void openMainPage() {
    Navigator.pushNamed(context, "/subjectDetail");
  }
  //Widget build(BuildContext context) {
  //return Scaffold(
  // appBar: AppBar(
  //   title: Text(widget.title),
  // ),
  // );
  //}
}
