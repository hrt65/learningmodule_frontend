import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:learning_module/main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

final navigatorKeyMain = GlobalKey<NavigatorState>();
final server_url = 'http://3.13.31.173:8000';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learing Module',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyApp();
  }
}
// CourseList()