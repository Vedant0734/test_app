import 'package:bgi_test_app/business_logic/test_timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/question_model.dart';
import '../models/quiz.dart';
import '../widget/widget.dart';
import '../quiz_play_widgets.dart';

class QuizPlay extends StatefulWidget {
  final Quiz quiz;
  final List<Question> questions;
  const QuizPlay({required this.quiz, super.key, required this.questions});

  @override
  State<QuizPlay> createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay> with WidgetsBindingObserver {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0,);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(totalSeconds: widget.quiz.timeInSeconds),
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
              child: Column(
                children: [
                  // InfoHeader(
                  //   id: widget.quiz.id,
                  //   length: questionSnaphot.docs.length,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  PageView.builder(
                    controller: pageController,
                    itemCount: widget.questions.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return QuestionTile(questionModel: widget.questions[index], index: index);
                    },
                  ),
                  //  ListView.builder(
                  //         itemCount: questionSnaphot.docs.length,
                  //         shrinkWrap: true,
                  //         physics: const ClampingScrollPhysics(),
                  //         itemBuilder: (context, index) {
                  //           return Column(
                  //             children: [
                  //               QuestionTile(
                  //                 questionModel:
                  //                     getQuestionModelFromDatasnapshot(
                  //                         questionSnaphot.docs[index]),
                  //                 index: index,
                  //               ),
                  //               SizedBox(
                  //                 height: 15.0,
                  //               )
                  //             ],
                  //           );
                  //         })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

// class InfoHeader extends StatefulWidget {
//   final int length;
//   final String id;
//   const InfoHeader({super.key, required this.length, required this.id});

//   @override
//   _InfoHeaderState createState() => _InfoHeaderState();
// }

// class _InfoHeaderState extends State<InfoHeader> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         // future: databaseService.getQuestionData(widget.id),
//         builder: (context, snapshot) {
//       return snapshot.hasData
//           ? Container(
//               height: 40,
//               margin: const EdgeInsets.only(left: 14),
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 children: <Widget>[
//                   NoOfQuestionTile(
//                     text: "Total",
//                     number: widget.length,
//                   ),
//                   NoOfQuestionTile(
//                     text: "NotAttempted",
//                     number: _notAttempted,
//                   ),
//                 ],
//               ),
//             )
//           : Container();
//     });
//   }
// }

class QuestionTile extends StatefulWidget {
  // final Quiz quiz;
  final Question questionModel;
  final int index;

  const QuestionTile({super.key, required this.questionModel, required this.index});

  @override
  State<QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
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
              "Q${widget.index + 1} ${widget.questionModel.description}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.isAnswered) {

                ///correct
                // if (widget.questionModel.option1 ==
                //     widget.questionModel.correctOption) {
                //   setState(() {
                //     optionSelected = widget.questionModel.option1;
                //     widget.questionModel.isAnswered = true;
                //     _correct = _correct + 1;
                //     _notAttempted = _notAttempted + 1;
                //   });
                // } else {
                //   setState(() {
                //     optionSelected = widget.questionModel.option1;
                //     widget.questionModel.isAnswered = true;
                //     _incorrect = _incorrect + 1;
                //     _notAttempted = _notAttempted - 1;
                //   });
                // }
              }
            },
            child: OptionTile(
              isSelected: false,
              description: "${widget.questionModel.option1}",
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.isAnswered) {
                ///correct
                // if (widget.questionModel.option2 ==
                //     widget.questionModel.correctOption) {
                //   setState(() {
                //     optionSelected = widget.questionModel.option2;
                //     widget.questionModel.isAnswered = true;
                //     _correct = _correct + 1;
                //     _notAttempted = _notAttempted + 1;
                //   });
                // } else {
                //   setState(() {
                //     optionSelected = widget.questionModel.option2;
                //     widget.questionModel.isAnswered = true;
                //     _incorrect = _incorrect + 1;
                //     _notAttempted = _notAttempted - 1;
                //   });
                // }
              }
            },
            child: OptionTile(
              description: "${widget.questionModel.option2}",
              isSelected: false,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.isAnswered) {
                ///correct
                // if (widget.questionModel.option3 ==
                //     widget.questionModel.correctOption) {
                //   setState(() {
                //     optionSelected = widget.questionModel.option3;
                //     widget.questionModel.isAnswered = true;
                //     _correct = _correct + 1;
                //     _notAttempted = _notAttempted + 1;
                //   });
                // } else {
                //   setState(() {
                //     optionSelected = widget.questionModel.option3;
                //     widget.questionModel.isAnswered = true;
                //     _incorrect = _incorrect + 1;
                //     _notAttempted = _notAttempted - 1;
                //   });
                // }
              }
            },
            child: OptionTile(
              description: "${widget.questionModel.option3}",
              isSelected: false,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(

            onTap: () {
              if (!widget.questionModel.isAnswered) {
                ///correct
                // if (widget.questionModel.option4 ==
                //     widget.questionModel.correctOption) {
                //   setState(() {
                //     optionSelected = widget.questionModel.option4;
                //     widget.questionModel.isAnswered = true;
                //     _correct = _correct + 1;
                //     _notAttempted = _notAttempted + 1;
                //   });
                // } else {
                //   setState(() {
                //     optionSelected = widget.questionModel.option4;
                //     widget.questionModel.isAnswered = true;
                //     _incorrect = _incorrect + 1;
                //     _notAttempted = _notAttempted - 1;
                //   });
                // }
              }
            },
            child: OptionTile(
              description: "${widget.questionModel.option4}",
              isSelected: false,
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

// class QuestionPage extends StatelessWidget {
//   const QuestionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
