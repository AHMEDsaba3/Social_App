class UserModel{
  String? name;
  String? email;
  String? phone;
  String? id;
  bool? isEmailVerified;
  String? image;
  String? bio;
  String? cover;

  UserModel({
    this.email,
    this.id,
    this.phone,
    this.name,
    this.isEmailVerified,
    this.bio,
    this.cover,
    this.image
});

  UserModel.fromJson(Map<String, dynamic> json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    id=json['uId'];
    isEmailVerified=json['isEmailVerified'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'isEmailVerified':isEmailVerified,
      'uId':id,
      'bio':bio,
      'cover':cover,
      'image':image
    };

  }

}