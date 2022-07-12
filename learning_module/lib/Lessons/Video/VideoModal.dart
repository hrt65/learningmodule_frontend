//@dart=2.9

class VideoModal
{
  String creator;
  String video_url;


  VideoModal({this.creator,this.video_url});
  factory VideoModal.fromJson(Map<dynamic,dynamic> json){
    return VideoModal(
      creator: json['creator'].toString(),
      video_url: json['video_url'].toString(),
    );
  }
}
