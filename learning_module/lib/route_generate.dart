//@dart=2.9
import 'package:flutter/material.dart';
import 'package:learning_module/Courses/courselist.dart';
import 'package:learning_module/Courses/src/pages/home_page.dart';
import 'package:learning_module/Courses/src/pages/recomended_page.dart';
import 'package:learning_module/Lessons/lessonlist.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch(settings.name){
      case CourseList.routeName:
        return MaterialPageRoute(settings: settings,builder:(context)=>CourseList() );
      case LessonList.routeName:
        final args = settings.arguments as String;
        return MaterialPageRoute(settings: settings,builder:(context)=>LessonList(courseid: args) );
      case HomePage.routeName:
        return MaterialPageRoute(settings: settings,builder:(context)=>HomePage() );
      case RecomendedPage.routeName:
        return MaterialPageRoute(settings: settings,builder:(context)=>RecomendedPage() );
      case LessonList.routeName:
        return MaterialPageRoute(settings: settings,builder:(context)=>LessonList() );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic>_errorRoute(){
    return MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(
          title: Text("ERROR"),
          centerTitle: true,

        ),
        body: Center(
          child:Text("Page not found"),
        ),
      );
    }
    );
  }

}