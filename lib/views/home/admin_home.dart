import 'package:bgi_test_app/models/quiz.dart';
import 'package:bgi_test_app/models/user.dart';
import 'package:bgi_test_app/services/database.dart';
import 'package:bgi_test_app/views/profile_page.dart';
import 'package:bgi_test_app/views/quiz_info.dart';
import 'package:flutter/material.dart';
import '../../helper/widgets/custom_drawer.dart';
import '../create_quiz.dart';
import '../../widget/widget.dart';

// question(id int not null , qId int not null , descr varchar(1000) , opt1 varchar(100), opt2 varchar(100), opt3 varchar(100), opt4 varchar(100) , correct varchar(100))

class AdminHome extends StatefulWidget {
  final User user;

  const AdminHome({super.key, required this.user});
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  DatabaseService databaseService = DatabaseService();
  Widget quizList() {
    return Column(
      children: [
        SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemCount: widget.user.quizes.length,
            itemBuilder: (context, index) {
              return QuizTile(quiz: widget.user.quizes[index]);
            },
          ),
        )
        // FutureBuilder<List<Map<String, dynamic>>>(
        //     future: databaseService.getQuizData(),
        //     builder: (context, snapshot) {
        //       print("building");
        //       print(snapshot.data);
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.active:
        //         case ConnectionState.none:
        //         case ConnectionState.waiting:
        //           return Center(
        //             child: Text("Fetching data"),
        //           );
        //         default:
        //           if (snapshot.hasError) {
        //             return Center(
        //               child: Text("No data found"),
        //             );
        //           }
        //           if (snapshot.hasData) {
        //             return ListView.builder(
        //                 shrinkWrap: true,
        //                 // ignore: prefer_const_constructors
        //                 physics: ClampingScrollPhysics(),
        //                 itemCount: snapshot.data!.length,
        //                 itemBuilder: (context, index) {
        //                   return Column(
        //                     children: [
        //                       QuizTile(
        //                           title: snapshot.data![index]["quizTitle"]
        //                               .toString(),
        //                           description: snapshot.data![index]
        //                                   ["quizDesc"]
        //                               .toString(),
        //                           id: snapshot.data![index]["id"],
        //                           noOfQuestions: snapshot.data![index]
        //                               ["noOfQuestions"]),
        //                       const SizedBox(
        //                         height: 15.0,
        //                       )
        //                     ],
        //                   );
        //                 });
        //           }
        //           return Center(
        //             child: Text("Something bad happended"),
        //           );
        //       }
        //     })
        // StreamBuilder(
        //     stream: FirebaseFirestore.instance.collection('QUIZ').snapshots(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         for (var element in snapshot.data!.docs) {
        //           print(element.data());
        //         }

        //         return ListView.builder(
        //             shrinkWrap: true,
        //             physics: const ClampingScrollPhysics(),
        //             itemCount: snapshot.data!.docs.length,
        //             itemBuilder: (context, index) {
        //               return Column(
        //                 children: [
        //                   QuizTile(
        //                     quiz: Quiz.fromJson(
        //                         snapshot.data!.docs[index].data()),
        //                   ),
        //                   const SizedBox(
        //                     height: 15.0,
        //                   )
        //                 ],
        //               );
        //             });
        //       } else {
        //         return Text("Fetching data");
        //       }
        //     })
      ],
    );
  }

  @override
  // void initState() {
    // databaseService.getQuizData().then((value) {
    //   setState(() {});
    // });
    // super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.grey.shade300,
      ),
      drawer: ReusableDrawer(user: widget.user),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}



class QuizTile extends StatelessWidget {
  final Quiz quiz;
  QuizTile({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => QuizInfo(quiz: quiz)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // Image.network(
              //   imageUrl,
              //   fit: BoxFit.cover,
              //   width: MediaQuery.of(context).size.width,
              // ),
              Container(
                color: Colors.grey.shade300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quiz.title,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        quiz.description,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
