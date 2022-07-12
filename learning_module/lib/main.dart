import 'package:flutter/material.dart';
import 'package:learning_module/Courses/courselist.dart';
// import 'package:learning_module/Lessons/Quiz/home.dart';
import 'package:learning_module/Lessons/Quiz/quizmodel.dart';
import 'package:learning_module/Lessons/Quiz/quizapis.dart';
import 'package:learning_module/Lessons/Quiz/home1.dart';

final navigatorKeyMain = GlobalKey<NavigatorState>();
final server_url = 'http://3.13.31.173:8000';

void main() {
  runApp(const MyApp());
  //getQuiz();
}

class MyApp extends StatelessWidget {
  // QuizModel quiz;
  // print(quiz);
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learing Module',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const CourseList(),
      home: QuizQuestions(),
    );
  }
}
