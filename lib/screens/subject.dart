import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class subjectPage extends StatefulWidget {
  @override
  _subjectPageState createState() => _subjectPageState();
}

class _subjectPageState extends State<subjectPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "KPR Learn",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          openCalenderPage();
                        },
                        child: Image(
                          image: AssetImage('assets/image/img1.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 0, top: 10, right: 0, bottom: 30),
                          child: Text(
                            'SUBJECTS',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // changing from 200 to 150 as to look better
                                height: 108.0,
                                width: 108.0,
                                child: ClipOval(
                                  child: InkWell(
                                    onTap: () {
                                      openMainPage();
                                    },
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/image/003.png'),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // changing from 200 to 150 as to look better
                                height: 108.0,
                                width: 108.0,
                                child: ClipOval(
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/image/001.png'),
                                  ),
                                ),
                              ),
                              Container(
                                // changing from 200 to 150 as to look better
                                height: 108.0,
                                width: 108.0,
                                child: ClipOval(
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/image/002.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openCalenderPage() {
    Navigator.pushNamed(context, "/calenderPage");
  }

  void openMainPage() {
    Navigator.pushNamed(context, "/homePage");
  }
}
