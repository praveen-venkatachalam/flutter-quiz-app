import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edmt_quiz_app/state/state_manager.dart';
import 'package:flutter_riverpod/all.dart';

class MyQuestionDetailPage extends StatefulWidget {
  MyQuestionDetailPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _MyQuestionDetailPageState();
}

class _MyQuestionDetailPageState extends State<MyQuestionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      var currentQuestion = watch(userViewQuestionState).state;

      return WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('${currentQuestion.questionId}(in database)'),
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
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeText(
                            '${currentQuestion.questionText}'), //Question
                        Visibility(
                          visible: (currentQuestion.isImageQuestion == null ||
                                  currentQuestion.isImageQuestion == 0
                              ? false
                              : true),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 15 * 3,
                            child: currentQuestion.isImageQuestion == 0
                                ? Container()
                                : Image.network(
                                    '${currentQuestion.questionImage}',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ), // If question is image, show image
                        Expanded(
                          child: ListTile(
                            title: AutoSizeText(
                              '${currentQuestion.answerA}',
                              style: TextStyle(
                                  color: currentQuestion.correctAnswer == 'A'
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                            leading: Radio(
                                value: 'A',
                                groupValue: currentQuestion.correctAnswer,
                                onChanged: null),
                          ),
                        ), //Answer A
                        Expanded(
                          child: ListTile(
                            title: AutoSizeText(
                              '${currentQuestion.answerB}',
                              style: TextStyle(
                                  color: currentQuestion.correctAnswer == 'B'
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                            leading: Radio(
                                value: 'B',
                                groupValue: currentQuestion.correctAnswer,
                                onChanged: null),
                          ),
                        ), //Answer B
                        Expanded(
                          child: ListTile(
                            title: AutoSizeText(
                              '${currentQuestion.answerC}',
                              style: TextStyle(
                                  color: currentQuestion.correctAnswer == 'C'
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                            leading: Radio(
                                value: 'C',
                                groupValue: currentQuestion.correctAnswer,
                                onChanged: null),
                          ),
                        ), //Answer C
                        Expanded(
                          child: ListTile(
                            title: AutoSizeText(
                              '${currentQuestion.answerD}',
                              style: TextStyle(
                                  color: currentQuestion.correctAnswer == 'D'
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                            leading: Radio(
                                value: 'D',
                                groupValue: currentQuestion.correctAnswer,
                                onChanged: null),
                          ),
                        ), //Answer D
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onWillPop: () async {
            Navigator.pop(context);
            return true;
          });
    });
  }
}
