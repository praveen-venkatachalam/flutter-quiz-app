import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edmt_quiz_app/database/category_provider.dart';
import 'package:flutter_edmt_quiz_app/state/state_manager.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyReadModePage extends StatefulWidget {
  MyReadModePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _MyReadModePageState();
}

class _MyReadModePageState extends State<MyReadModePage> {
  SharedPreferences prefs;
  int indexPage = 0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();
      indexPage = await prefs.getInt(
          '${context.read(questionCategoryState).state.name}_${context.read(questionCategoryState).state.ID}');
      Future.delayed(Duration(milliseconds: 500)).then((value) =>
          buttonCarouselController
              .animateToPage(indexPage == null ? 0 : indexPage));
    });
  }

  @override
  Widget build(BuildContext context) {
    var questionModule = context.read(questionCategoryState).state;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(questionModule.name),
            leading: GestureDetector(
              onTap: () => showCloseDialog(questionModule),
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: FutureBuilder(
              future: getQuestionByCategory<List<Question>>(questionModule.ID),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                else if (snapshot.hasData) {
                  if(snapshot.data.length > 0){
                    return Container(margin: const EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        padding: const EdgeInsets.only(left: 4,right: 4,bottom: 4,top: 10),
                        child: SingleChildScrollView(
                          child: column(children:[
                            //yesterday
                          ]),
                        ),
                      ),
                    ),)
                  }
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
          ),
        ),
        onWillPop: () async {
          showCloseDialog(questionModule);
          return true;
        });
  }

  showCloseDialog(Category questionModule) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Text('Close'),
              content: Text('Do you want to save this question index?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: Text('No')),
                TextButton(
                    onPressed: () {
                      prefs.setInt(
                          '${context.read(questionCategoryState).state.name}_${context.read(questionCategoryState).state.ID}',
                          context.read(currentReadPage).state);
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: Text('Yes'))
              ],
            ));
  }
}
