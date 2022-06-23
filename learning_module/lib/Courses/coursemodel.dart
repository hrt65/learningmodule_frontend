//@dart=2.9

class CourseModel
{
  int id;
  String coursename;
  CourseModel({this.id,this.coursename});
  factory CourseModel.fromJson(Map<dynamic,dynamic> json){
    return CourseModel(
        id:json['id'] ,
        coursename: json['coursename'].toString()
    );

  }

}