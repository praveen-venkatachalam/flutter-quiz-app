import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edmt_quiz_app/database/db_helper.dart';
import 'package:flutter_edmt_quiz_app/database/question_provider.dart';
import 'package:flutter_edmt_quiz_app/state/state_manager.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyResultPage extends StatefulWidget {
  MyResultPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _MyResultPageState();
}

class _MyResultPageState extends State<MyResultPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Quiz exam'),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            color: Colors.white10,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                AutoSizeText(
                  'Limit',
                  style: TextStyle(color: Colors.blueAccent),
                  maxLines: 1,
                ),
                LinearPercentIndicator(
                  lineHeight: 28,
                  percent: 0.5,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
                AutoSizeText(
                  'Your mark ${((10.0 / context.read(userListAnswer).state.length) * context.read(userListAnswer).state.where((answer) => answer.isCorrect).toList().length).toStringAsFixed(1)} /10.0',
                  style: TextStyle(color: Colors.blueAccent),
                  maxLines: 1,
                ),
                LinearPercentIndicator(
                  lineHeight: 28,
                  percent: context
                          .read(userListAnswer)
                          .state
                          .where((e) => e.isCorrect)
                          .toList()
                          .length /
                      context.read(userListAnswer).state.length,
                  backgroundColor: Colors.brown,
                  progressColor: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Correct Answer')
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Wrong Answer')
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Not Answer')
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: context
                      .read(userListAnswer)
                      .state
                      .asMap()
                      .entries
                      .map((question) {
                    return GestureDetector(
                      child: Card(
                        elevation: 2,
                        color: question.value.answered.isEmpty
                            ? Colors.white
                            : question.value.isCorrect
                                ? Colors.green
                                : Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'No ${question.key + 1}\n ${question.value.answered}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: question.value.answered.isEmpty
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        var questionNeedView =
                            await getQuestionById(question.value.questionId);
                        context.read(userViewQuestionState).state =
                            questionNeedView;
                        Navigator.pushNamed(context, "/questionDetail");
                      },
                    );
                  }).toList(),
                ))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        });
  }

  void showCloseDialog() {}

  Future<Question> getQuestionById(questionId) async {
    var db = await copyDB();
    return await QuestionProvider().getQuestionById(db, questionId);
  }
}
