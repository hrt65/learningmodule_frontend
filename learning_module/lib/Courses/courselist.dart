//@dart=2.9

import 'package:flutter/material.dart';
import 'package:learning_module/Courses/courseapis.dart';

class CourseList extends StatelessWidget {
  const CourseList({Key key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Course List"),
      ),
      body: FutureBuilder(
        future:getCourseList(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData)
            {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const Icon(Icons.list),
                        trailing: Text(
                          "${snapshot.data[index].coursename}",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("List item $index"));
                  });


            }
          else
            {
              return CircularProgressIndicator();
            }

        },
      ),

    );
  }
}