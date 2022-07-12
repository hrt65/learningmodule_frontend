//@dart=2.9
import 'package:flutter/material.dart';
import 'package:learning_module/Courses/courseapis.dart';
// import 'package:learning_module/Courses/src/helper/courseModel.dart';
import 'package:learning_module/Courses/coursemodel.dart';
import 'package:learning_module/Courses/src/helper/quad_clipper.dart';
import 'package:learning_module/Courses/src/pages/home_page.dart';
import 'package:learning_module/Courses/src/theme/color/light_color.dart';
import 'package:learning_module/Courses/src/theme/theme.dart';

class LessonList extends StatelessWidget {
  static const routeName = 'lessonlist';
  String courseid;
  LessonList({Key key,int courseid}) : super(key: key);



  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 120,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.orange,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, LightColor.lightOrange2)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, LightColor.darkOrange)),
              Positioned(
                  top: -230,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 40,
                          ),
                          // Align(
                          //     alignment: Alignment.center,
                          //     child: Text(
                          //       widget.title,
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 30,
                          //           fontWeight: FontWeight.w500),
                          //     ))
                        ],
                      ))),
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(BuildContext context, String title) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      height: 68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(
                  color: LightColor.extraDarkPurple,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 20),
                  _chip("Data Scientist", LightColor.yellow, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Analyst", LightColor.seeBlue, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Engineer", LightColor.orange, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Scientist", LightColor.lightBlue, height: 5),
                ],
              )),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _lessonList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: FutureBuilder(
            future:getLessonList(courseid),
            builder: (context,snapshot) {
              if(snapshot.hasData)
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _lessonInfo(context, snapshot.data[index] as LessonModel,
                              _decorationContainerA(Colors.redAccent, -110, -85),
                              background: LightColor.seeBlue),
                          Divider(
                            thickness: 1,
                            endIndent: 20,
                            indent: 20,
                          ),
                        ],
                      );
                    }
                );
              else return CircularProgressIndicator();
            }
        ),
      ),
    );
  }

  Widget _card(BuildContext context,
      {Color primaryColor = Colors.redAccent, Widget backWidget}) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width * .34,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: backWidget,
      ),
    );
  }

  Widget _lessonInfo(BuildContext context, LessonModel model, Widget decoration,
      {Color background}) {
    return GestureDetector(
      onTap: (){
        // Navigator.pushReplacementNamed(context, LessonList.routeName,arguments: model.id);
      },
      child: Container(
          height: 170,
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: .7,
                child: _card(context,
                    primaryColor: background, backWidget: decoration),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Text(model.coursename,
                                  style: TextStyle(
                                      color: LightColor.purple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: background,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Rs.${model.price.toString()}',
                                style: TextStyle(
                                  color: LightColor.grey,
                                  fontSize: 14,
                                )),
                            SizedBox(width: 10)
                          ],
                        ),
                      ),
                      Text(model.shortdescription,
                          style: AppTheme.h6Style.copyWith(
                            fontSize: 12,
                            color: LightColor.grey,
                          )),
                      SizedBox(height: 15),
                      Text(model.description,
                          style: AppTheme.h6Style.copyWith(
                              fontSize: 12, color: LightColor.extraDarkPurple)),
                      SizedBox(height: 15),
                      // Row(
                      //   children: <Widget>[
                      //     _chip(model.tag1, LightColor.darkOrange, height: 5),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     _chip(model.tag2, LightColor.seeBlue, height: 5),
                      //   ],
                      // )
                    ],
                  ))
            ],
          )),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Widget _decorationContainerA(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        _smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
            CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  Widget _decorationContainerB() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.lightOrange2,
            child: CircleAvatar(
                radius: 30, backgroundColor: LightColor.darkOrange),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child:
            CircleAvatar(backgroundColor: LightColor.yellow, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circularContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  Widget _decorationContainerC() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: -65,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xfffeeaea),
          ),
        ),
        Positioned(
            bottom: -30,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.yellow, radius: 40))),
        _smallContainer(
          Colors.yellow,
          35,
          70,
        ),
      ],
    );
  }

  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
      //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        label: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: LightColor.background,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.purple,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.star_border),
          _bottomIcons(Icons.book),
          _bottomIcons(Icons.person),
        ],
        onTap: (index) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _header(context),
              SizedBox(height: 20),
              _categoryRow(context, "Start a new career"),
              _lessonList(context)
            ],
          ),
        ),
      ),
    );
  }
}
