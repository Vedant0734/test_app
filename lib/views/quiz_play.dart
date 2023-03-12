import 'package:bgi_test_app/business_logic/quiz/bloc/quiz_bloc.dart';
import 'package:bgi_test_app/business_logic/qustions/bloc/questions_bloc.dart';
import 'package:bgi_test_app/business_logic/test_timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/quiz/warning_bloc/warning_bloc.dart';
import '../business_logic/qustions/question_model.dart';
import '../business_logic/quiz/quiz.dart';
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
    pageController = PageController(
      initialPage: 0,
    );
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused){
      context.read<WarningBloc>().add(WarnUser());
    }
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TimerBloc(totalSeconds: widget.quiz.timeInSeconds),
        ),
        BlocProvider(
          create: (context) => QuestionsBloc(questions: widget.questions),
        )
      ],
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<QuizBloc, QuizState>(
              listener: (context, state) {
                if(state is QuizSubmitInProgress){
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
                            children: const[
                              Text(
                                "Time's up",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10.0,
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
                } else if(state is QuizSubmitFailed){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.reason)));
                }
              },
            ),
            BlocListener<TimerBloc, TimerState>(
              listener: (_, state) {
                if (state is TimeUpState) {
                  final questions = BlocProvider.of<QuestionsBloc>(context).state.questions;
                  print(":the ans");
                  for (var element in questions) {
                    print(element.answer);
                  }
                  context.read<QuizBloc>().add(SubmitQuiz(questions));
                }
              },
            ),
            BlocListener<WarningBloc, WarningState>(
              listener: (context, state) {
                if(state is EndQuizState){
                  final questions = BlocProvider.of<QuestionsBloc>(context).state.questions;
                  print("ending the quiz");
                  for (var element in questions) {
                    print(element.answer);
                  }
                  context.read<QuizBloc>().add(SubmitQuiz(questions, isTerminated: true));
                } else if(state is WarningUpdatedState){
                  showDialog(context: context, 
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.red,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text("OK"))
                    ],
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.warning, size: 40,),
                        const SizedBox(height: 10.0,),
                        const Text("Do not leave the application while the test is in progress", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("This is your ${state.warningCount} warning. If you leave the applicataion more than 3 times your test will be terminated.")
                      ],
                    ),
                  ),);
                }
              },
            ),
          ], 
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              actions: [
                BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    final currentBrightness = Theme.of(context).brightness;
                    return Container(
                      margin: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 5.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: currentBrightness == Brightness.light
                            ? Colors.grey.shade200.withOpacity(0.7)
                            : Colors.grey.shade700.withOpacity(0.7),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        children: [
                          Text(((state.seconds ~/ 3600).floor()).toString(),
                              style: TextStyle(
                                  fontSize: 19,
                                  color: currentBrightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white70)),
                          Text(" : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: currentBrightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white70)),
                          Text(((state.seconds ~/ 60) % 60).toString(),
                              style: TextStyle(
                                  fontSize: 19,
                                  color: currentBrightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white70)),
                          Text(" : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: currentBrightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white70)),
                          Text(((state.seconds ~/ 1) % 60).toString(),
                              style: TextStyle(
                                  fontSize: 19,
                                  color: currentBrightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white70)),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
            drawer: Drawer(
              elevation: 10.0,
              child: Column(
                children: [
                  const SizedBox(height: 50.0,),
                  BlocBuilder<QuestionsBloc, QuestionsState>(
                    builder: (context, state) {
                      return NoOfQuestionTile(text: "Total", number: state.questions.length);
                    },
                  ),
                  BlocBuilder<QuestionsBloc, QuestionsState>(
                    builder: (context, state) {
                      int answeredQuestionsCount = 0;
                      for (var element in state.questions) {
                        if(element.answer != null){
                          answeredQuestionsCount ++;
                        }
                      }
                      return NoOfQuestionTile(text: "Answered", number: answeredQuestionsCount);
                    },
                  ),
                ],
              ),
            ),
            body: PageView.builder(
              controller: pageController,
              itemCount: widget.questions.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: QuestionTile(
                      questionModel: widget.questions[index], index: index),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

class InfoHeader extends StatelessWidget {
  final int totalQuestions, unattemptedQuestions;
  const InfoHeader(
      {super.key,
      required this.totalQuestions,
      required this.unattemptedQuestions});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(builder: (context, snapshot) {
      return Row(
        children: [
          NoOfQuestionTile(
            text: "NotAttempted",
            number: unattemptedQuestions,
          ),
        ],
      );
    });
  }
}

class QuestionTile extends StatelessWidget {
  final Question questionModel;
  final int index;

  const QuestionTile(
      {super.key, required this.questionModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Q${index + 1}. ${questionModel.description}",
            style:
                TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                OptionTile(
                  questionId: questionModel.questionId,
                  description: questionModel.option1,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                OptionTile(
                  questionId: questionModel.questionId,
                  description: questionModel.option2,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                OptionTile(
                  questionId: questionModel.questionId,
                  description: questionModel.option3,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                OptionTile(
                  questionId: questionModel.questionId,
                  description: questionModel.option4,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
