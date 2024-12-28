class PostsModel{
  String? text;
  String? dateTime;
  String? uId;
  String? postImage;
  String? name;
  String? image;
  PostsModel({
    this.text,
    this.uId,
    this.dateTime,
    this.name,
    this.postImage,
    this.image,
  });
  PostsModel.fromJson(Map<String, dynamic> json){
    name=json['name'];
    text=json['text'];
    uId=json['uId'];
    postImage=json['postImage'];
    dateTime=json['dateTime'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'text':text,
      'uId':uId,
      'postImage':postImage,
      'dateTime':dateTime,
      'image':image,
    };

  }
}