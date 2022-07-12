//@dart=2.9
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:learning_module/Lessons/Video/VideoModal.dart';
import 'package:retry/retry.dart';
import 'package:learning_module/main.dart';

int maxAttempts = 5;
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
 int id = 1;
// String server_url = 'http://3.13.31.173:8000';
//
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

Future<void> uploadFile(File video, String type) async {
  try {
    var data = await getS3Url(id, type);
    String url = data["aws_presigned_url_response"];
    String directurl = data["directURL"];

    var response = await http.put(Uri.parse(url), body: video.openRead());
    if (response.statusCode == 200) {
      print(response.body);
      await sendSuccessUpload(directurl, id);
    }
  } catch (e) {
    throw ('Error uploading video');
  }
}

Future getS3Url(int id, String type) async {
  try {
    var response =
    await http.get(Uri.parse('${server_url}/AWSS3url/${id}/${type}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  } catch (e) {
    throw ('Error uploading photo');
  }
}

Future sendSuccessUpload(String directURL, int id) async {
  // await http.put(url: '${server_url}/${id}', body: jsonEncode(directURL));
  await http.put(
    Uri.parse('${server_url}/successupload/${id}'),
    body: jsonEncode(directURL),
  );
}

void main() => runApp(MyVideoApp());

class MyVideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  File _image;
  File _cameraImage;
  File _video;
  File _cameraVideo;

  ImagePicker picker = ImagePicker();

  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

  // This funcion will helps you to pick and Image from Gallery
  _pickImageFromGallery() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image = File(pickedFile.path);

    setState(() {
      _image = image;
    });
  }

  _pickImageFromCamera() async {
    PickedFile pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    File image = File(pickedFile.path);

    setState(() {
      _cameraImage = image;
    });
  }

  _pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);

    _video = File(pickedFile.path);
    String type = "video";
    uploadFile(_video, type);
  }

  _pickVideoFromCamera() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile.path);

    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image / Video Picker"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                if (_image != null)
                  Image.file(_image)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: Text("Pick Image From Gallery"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                if (_cameraImage != null)
                  Image.file(_cameraImage)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickImageFromCamera();
                  },
                  child: Text("Pick Image From Camera"),
                ),
                if (_video != null)
                  _videoPlayerController.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Text("Pick Video From Gallery"),
                ),
                if (_cameraVideo != null)
                  _cameraVideoPlayerController.value.isInitialized
                      ? AspectRatio(
                    aspectRatio:
                    _cameraVideoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_cameraVideoPlayerController),
                  )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickVideoFromCamera();
                  },
                  child: Text("Pick Video From Camera"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}