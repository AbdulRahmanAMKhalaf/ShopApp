class LoginModel{
  bool ?status;
  String ?message;
  UserData?data;

  LoginModel.fromJason(dynamic jason){
    this.status=jason["status"];
    this.message=jason["message"];
    this.data=jason["data"]!=null?UserData.fromJason(jason["data"]):null;
  }
}
class UserData{
  int ?id;
  String ?name;
  String ?email;
  String ?phone;
  String ?image;
  String ?token;
  //named constructor
  UserData.fromJason(dynamic json){
    this.id=json["id"];
    this.name=json["name"];
    this.email=json["email"];
    this.phone=json["phone"];
    this.image=json["image"];
    this.token=json["token"];
  }
}