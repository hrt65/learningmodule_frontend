//@dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_module/Courses/courseapis.dart';
import 'package:learning_module/Courses/coursemodel.dart';

class CourseList extends StatelessWidget {
  static const routeName = 'courselist';
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
                    return CourseWidget(course:snapshot.data[index]);
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

class CourseWidget extends StatefulWidget {
  CourseModel course;
   CourseWidget({Key key,this.course}) : super(key: key);

  @override
  _CourseWidgetState createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color:Colors.blue.shade100,borderRadius: BorderRadius.circular(20.0)),
          child: ListTile(

            title:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.course.coursename),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.course.shortdescription,style:TextStyle(color:Colors.black54)),
                ),



              ],
            ),
            subtitle:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("price ${widget.course.price} INR"),
                Text("level ${widget.course.level}"),


              ],
            )


          ),
        ),
      ),
    );
  }
}
