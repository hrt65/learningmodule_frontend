// //@dart=2.9
// import 'package:flutter/material.dart';
// import 'package:learning_module/Lessons/Video/VideoModal.dart';
// import 'package:retry/retry.dart';
// import 'package:learning_module/main.dart';
// import 'dart:async';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:learning_module/Video/VideoModal.dart';
//
//
// int maxAttempts = 5;
// NavigatorState failureNavState;
// onRetry() {
//   if (failureNavState == null) {
//     failureNavState = navigatorKeyMain.currentState;
//     showDialog(
//       context: navigatorKeyMain.currentContext,
//       builder: (context) => Center(
//         child: Padding(
//           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
//           child: Material(
//             color: Colors.transparent,
//             child: Text(
//               'Check your internet connection',
//               style: TextStyle(fontSize: 24),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// int id = 1;
// Future getVideo() async {
//   failureNavState = null;
//   final http.Response response = await retry(
//         () => http.get(
//       Uri.parse('${server_url}/video/${id}'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//     ),
//     maxAttempts: maxAttempts,
//     onRetry: (e) => onRetry(),
//   );
//
//   failureNavState?.pop();
//   print(response.body);
//
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     VideoModal video = data.map<VideoModal>((json) => VideoModal().fromJson(json));
//     return video;
//   }
//
//   else {
//     throw Exception("API of Video failed");
//   }
// }
//
// Future<void> uploadFile(File video, String type) async {
//   try {
//     var data = await getS3Url(id, type);
//     String url = data["aws_presigned_url_response"];
//     String directurl = data["directURL"];
//
//     var response = await http.put(Uri.parse(url), body: video.openRead());
//     if (response.statusCode == 200) {
//       await sendSuccessUpload(directurl, id);
//     }
//   } catch (e) {
//     throw ('Error uploading photo');
//   }
// }
//
// Future getS3Url(int id, String type) async {
//   try {
//     var response =
//     await http.get(Uri.parse('${server_url}/AWSS3url/${id}/${type}'));
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     }
//   } catch (e) {
//     throw ('Error uploading photo');
//   }
// }
//
// Future sendSuccessUpload(String directURL, int id) async {
//   // await http.put(url: '${server_url}/${id}', body: jsonEncode(directURL));
//   await http.put(
//     Uri.parse('${server_url}/successupload/${id}'),
//     body: jsonEncode(directURL),
//   );
// }