class UserModel{
  String? name;
  String? email;
  String? phone;
  String? id;
  bool? isEmailVerified;

  UserModel({
    this.email,
    this.id,
    this.phone,
    this.name,
    this.isEmailVerified
});

  UserModel.fromJson(Map<String, dynamic> json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    id=json['uId'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'isEmailVerified':isEmailVerified,
      'uId':id
    };

  }

}