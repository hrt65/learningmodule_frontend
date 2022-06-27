//@dart=2.9
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:learning_module/main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import'package:learning_module/Courses/coursemodel.dart';
import 'dart:io';

int maxAttempts = 5;
NavigatorState failureNavState;
onRetry() {
  if (failureNavState == null) {
    failureNavState = navigatorKeyMain.currentState;
    showDialog(
      context: navigatorKeyMain.currentContext,
      builder: (context) => Center(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Check your internet connection',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}



Future getCourseList() async {
  failureNavState = null;
  final http.Response response = await retry(
        () => http.get(
      Uri.parse('${server_url}/Courses/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // "Authorization": "Token " + token,
      },

    ),
    maxAttempts: maxAttempts,
    onRetry: (e) => onRetry(),
  );
  failureNavState?.pop();
  print(response.body);
  if (response.statusCode == 200) {

    final data = jsonDecode(response.body)  ;
    List<CourseModel> courselist = data.map<CourseModel>((json)=>CourseModel.fromJson(json)).toList();
    return courselist;


  } else {

    throw Exception("course api fail");
  }
}