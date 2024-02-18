class RegisterModel{
  bool ?status;
  String ?message;
  DataModel ?data;
  RegisterModel.fromJason(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?DataModel.fromJason(json['data']):null;
  }
}
class DataModel{
  String ?name;
  String ?phone;
  String ?email;
  int ?id;
  String ?image;
  String ?token;
  DataModel.fromJason(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    id=json['id'];
    image=json['image'];
    token=json['token'];
  }
}