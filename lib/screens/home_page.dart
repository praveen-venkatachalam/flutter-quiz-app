import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edmt_quiz_app/database/category_provider.dart';
import 'package:flutter_edmt_quiz_app/database/db_helper.dart';
import 'package:flutter_edmt_quiz_app/state/state_manager.dart';
import 'package:flutter_riverpod/all.dart';

class MyCategoryPage extends StatefulWidget {
  MyCategoryPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _MyCategoryPage();
}

class _MyCategoryPage extends State<MyCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f6fd),
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder<List<Category>>(
          future: getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text('${snapshot.error}'),
              );
            else if (snapshot.hasData) {
              //IF snapshot has data,that mean Categories load success
              //So we will add more Category with name 'Exam' to let user do quiz
              //all categories when click -> Read more, help user learn from quiz
              //only 'Exam' category help user make a quiz
              Category category = new Category();
              category.ID = -1;
              category.name = "Module Test";
              snapshot.data.add(category);
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2,
                padding: const EdgeInsets.all(2.0),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 2.0,
                children: snapshot.data.map((category) {
                  return GestureDetector(
                    child: Card(
                      elevation: 1.5,
                      color: category.ID == -1 ? Colors.green : Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.book_outlined,
                              color: Colors.green.withOpacity(0.5),
                            ),
                          ),
                          Center(
                              child: AutoSizeText(
                            '${category.name}',
                            style: TextStyle(
                                color: category.ID == -1
                                    ? Colors.white
                                    : Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                    ),
                    onTap: () {
                      context.read(questionCategoryState).state = category;
                      if (category.ID != -1) //if not equal 'exam'
                      {
                        context.read(isTestMode).state = false;
                        Navigator.pushNamed(context, "/readMode");
                      } else {
                        context.read(isTestMode).state = true;
                        Navigator.pushNamed(context, "/testMode");
                      }
                    },
                  );
                }).toList(),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ));
  }

  Future<List<Category>> getCategories() async {
    var db = await copyDB();
    var result = await CategoryProvider().getCategories(db);
    context.read(categoryListProvider).state = result;
    return result;
  }
}
