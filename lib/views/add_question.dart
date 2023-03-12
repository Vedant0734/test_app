import 'package:bgi_test_app/models/temp_question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/quiz/new_quiz/bloc/new_quiz_bloc.dart';

class AddQuestionScreen extends StatefulWidget {
  final TemporaryQuestion question;
  final PageController pageController;
  const AddQuestionScreen({super.key, required this.question, required this.pageController});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.question.description,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter Question" : null,
                  decoration: const InputDecoration(hintText: "Question"),
                  onChanged: (val) {
                    widget.question.description = val;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  initialValue: widget.question.option1,
                  validator: (val) => val!.isEmpty ? "Option1 " : null,
                  decoration: const InputDecoration(
                      hintText: "Option1 (Correct Answer)"),
                  onChanged: (val) {
                    widget.question.option1 = val;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  initialValue: widget.question.option2,
                  validator: (val) => val!.isEmpty ? "Option2 " : null,
                  decoration: const InputDecoration(hintText: "Option2"),
                  onChanged: (val) {
                    widget.question.option2 = val;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  initialValue: widget.question.option3,
                  validator: (val) => val!.isEmpty ? "Option3 " : null,
                  decoration: const InputDecoration(hintText: "Option3"),
                  onChanged: (val) {
                    widget.question.option3 = val;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  initialValue: widget.question.option4,
                  validator: (val) => val!.isEmpty ? "Option4 " : null,
                  decoration: const InputDecoration(hintText: "Option4"),
                  onChanged: (val) {
                    widget.question.option4 = val;
                  },
                ),
                BlocListener<NewQuizBloc, NewQuizState>(
                  listener: (context, state) {
                    if(state is QuestionAddedState){
                      widget.pageController.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);                        
                    }
                  },
                  child: const SizedBox(
                    height: 50,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          context.read<NewQuizBloc>().add(CreateQuiz());
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Text(
                          "Submit",
                          style:
                              TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<NewQuizBloc>().add(AddQuestion());                          
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Text(
                          "Add Question",
                          style:
                              TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}
