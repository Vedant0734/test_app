import 'package:bgi_test_app/business_logic/test_timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/quiz.dart';
import '../services/database.dart';
import '../widget/widget.dart';
import '../quiz_play_widgets.dart';

class QuizPlay extends StatefulWidget {
  final Quiz quiz;
  const QuizPlay(this.quiz, {super.key});

  @override
  State<QuizPlay> createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(totalSeconds: 20),
      child: Builder(builder: (context) {
        return BlocListener<TimerBloc, TimerState>(
          listener: (context, state) {
            if (state is TimeUpState) {
              showDialog(
                context: context,
                builder: (context) {
                  return WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Time up",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text("Submitting ..."),
                          SizedBox(
                            height: 10.0,
                          ),
                          CircularProgressIndicator(
                            strokeWidth: 2.5,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: AppLogo(),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              // brightness: Brightness.light,
              elevation: 0.0,
              actions: [
                BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    return Text(
                      state.seconds.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    );
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    InfoHeader(
                      id: widget.quiz.id,
                      length: questionSnaphot.docs.length,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    questionSnaphot.docs == null
                        ? Container(
                            child: const Center(
                              child: Text("No Data"),
                            ),
                          )
                        : ListView.builder(
                            itemCount: questionSnaphot.docs.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  QuizPlayTile(
                                    questionModel:
                                        getQuestionModelFromDatasnapshot(
                                            questionSnaphot.docs[index]),
                                    index: index,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  )
                                ],
                              );
                            })
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;
  final String id;
  const InfoHeader({super.key, required this.length, required this.id});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: databaseService.getQuestionData(widget.id),
        builder: (context, snapshot) {
      return snapshot.hasData
          ? Container(
              height: 40,
              margin: const EdgeInsets.only(left: 14),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  NoOfQuestionTile(
                    text: "Total",
                    number: widget.length,
                  ),
                  NoOfQuestionTile(
                    text: "NotAttempted",
                    number: _notAttempted,
                  ),
                ],
              ),
            )
          : Container();
    });
  }
}

class QuizPlayTile extends StatefulWidget {
  final Question questionModel;
  final int index;

  const QuizPlayTile(
      {super.key, required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1} ${widget.questionModel.question}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "A",
              description: "${widget.questionModel.option1}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "B",
              description: "${widget.questionModel.option2}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "C",
              description: "${widget.questionModel.option3}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "D",
              description: "${widget.questionModel.option4}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
