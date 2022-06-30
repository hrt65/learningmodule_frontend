//@dart=2.9

class CourseModel
{
  int id;
  String coursename;
  int coursecreator;
  String shortdescription;
  String description;
  String requirements;
  String languages;
  int price;
  int level;
  String thumbnail;
  String introvideo;
  String createdate;
  String lastupdate;


  CourseModel({this.id,this.coursename,this.description,this.coursecreator,this.createdate,this.introvideo,this.languages,this.lastupdate,this.price,this.requirements,this.level,this.shortdescription,this.thumbnail});
  factory CourseModel.fromJson(Map<dynamic,dynamic> json){
    return CourseModel(
        id:json['id'] ,
        coursename: json['Course_title'].toString(),
         coursecreator:json['Course_creatore'],
     shortdescription:json['Course_short_description'].toString(),
     description:json['course_description'].toString(),
     requirements:json['course_requirements'].toString(),
         languages:json['course_languages'].toString(),
        price:json['course_price'],
        level:json['course_level'],
         thumbnail:json['course_thumbnail'].toString(),
     introvideo:json['course_video_url'].toString(),
     createdate:json['course_created_at'].toString(),
    lastupdate:json['course_updated_at'].toString(),

    );

  }

}

//Assignemnt
//Videolesson
//Quiz
//Article

