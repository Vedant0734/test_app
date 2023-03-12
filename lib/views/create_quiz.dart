import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../business_logic/quiz/new_quiz/bloc/new_quiz_bloc.dart';
import '../views/add_question.dart';
import '../widget/widget.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewQuizBloc(),
      child: Builder(builder: (context) {
        return BlocListener<NewQuizBloc, NewQuizState>(
          listener: (context, state) {
            if(state is QuizCreationInProgress){
              showDialog(context: context, builder: (context) => AlertDialog(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const[
                    Center(child: CircularProgressIndicator(),),
                  ],
                ),
              ),);
            } else if(state is QuizCreationFailed){
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Failed: ${state.reason}")
              ));
            } else if(state is QuizCreationSuccess){
              
              Navigator.pop(context);
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              if (context.read<NewQuizBloc>().state is QuizCreationSuccess) {
                return true;
              }
              bool? popScreen = await showDialog<bool>(context: context, barrierDismissible: true, builder: (context) => AlertDialog(
                title: const Text("Leave screen?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const[
                    Text("Are you sure you want to leave this screen?"),
                    Text("You will lose all of your progress.")
                  ],
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true), 
                    child: const Text("Leave", style: TextStyle(color: Colors.red))),
                ],
              ),);
              if (popScreen != null) {
                return Future.value(popScreen);
              }
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: const AppLogo(),
                elevation: 0.0,
              ),
              body: PageView(
                controller: pageController,
                children: [
                  QuizDetails(formKey: _formKey, pageController: pageController),
                  const QuestionsListWidget()
                ],
              )
            ),
          ),
        );
      }),
    );
  }
}

class QuestionsListWidget extends StatefulWidget {
  const QuestionsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionsListWidget> createState() => _QuestionsListWidgetState();
}

class _QuestionsListWidgetState extends State<QuestionsListWidget> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewQuizBloc, NewQuizState>(
      builder: (context, state) {
        return PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: state.questions.length,
          itemBuilder: (context, index) {
            return AddQuestionScreen(
              pageController: pageController,
              question: state.questions[index],);    
          },
        );
      },
    );
  }
}

class QuizDetails extends StatelessWidget {
  const QuizDetails({
    Key? key,
    required this.pageController,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final quiz = context.read<NewQuizBloc>().state.quiz;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: quiz.title,
                validator: (val) =>
                    val!.isEmpty ? "Enter Quiz Title" : null,
                decoration: const InputDecoration(hintText: "Quiz Title"),
                onChanged: (value) => quiz.title = value,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: quiz.description,
                validator: (val) =>
                    val!.isEmpty ? "Enter Quiz Description" : null,
                decoration: const InputDecoration(hintText: "Quiz Description"),
                onChanged: (value) => quiz.description = value,
              ),
              const SizedBox(
                height: 5,
              ),
              MyTextFieldDatePicker(
                initialDate: quiz.deadLineOfSubmission ?? DateTime.now(),
                labelText: "Last submission date",
                onDateChanged: (value) {
                  quiz.deadLineOfSubmission = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenSize.width*0.4,
                    child: DropdownButtonFormField<int>(
                      value: quiz.timeInHours,
                      hint: const Text("Hours"),
                      items: const[
                        DropdownMenuItem(
                          value: 0,
                          child:  Text("00")
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child:  Text("01")
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child:  Text("02")
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child:  Text("03")
                        ),
                      ], 
                      onChanged: (value) {
                        if(value != null){
                          quiz.timeInHours = value;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width*0.4,
                    child: DropdownButtonFormField<int>(
                      value: quiz.timeInMinutes,
                      hint: const Text("Minutes"),
                      items: const[
                        DropdownMenuItem(
                          value: 0,
                          child: Text("00")
                        ),
                        DropdownMenuItem(
                          value: 5,
                          child:  Text("05")
                        ),
                        DropdownMenuItem(
                          value: 10,
                          child:  Text("10")
                        ),
                        DropdownMenuItem(
                          value: 15,
                          child:  Text("15")
                        ),
                        DropdownMenuItem(
                          value: 20,
                          child:  Text("20")
                        ),
                        DropdownMenuItem(
                          value: 30,
                          child:  Text("30")
                        ),
                        DropdownMenuItem(
                          value: 45,
                          child:  Text("45")
                        ),
                      ], 
                      onChanged: (value) {
                        if(value != null){
                          quiz.timeInMinutes = value;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0,),
              GestureDetector(
                onTap: () {
                  pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Add Questions",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextFieldDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime initialDate;
  final DateFormat? dateFormat;
  final FocusNode? focusNode;
  final String? labelText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  const MyTextFieldDatePicker({
    super.key, 
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.dateFormat,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<MyTextFieldDatePicker> createState() => _MyTextFieldDatePicker();
}

class _MyTextFieldDatePicker extends State<MyTextFieldDatePicker> {
  late TextEditingController _controllerDate;
  late DateFormat _dateFormat;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat!;
    } else {
      _dateFormat = DateFormat.yMMMMd();
    }

    _selectedDate = widget.initialDate;

    _controllerDate = TextEditingController();
    _controllerDate.text = _dateFormat.format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: _controllerDate,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controllerDate.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: today.add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _controllerDate.text = _dateFormat.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }
  }
}