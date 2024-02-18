class UpdateProfileModel{
 bool ?status;
 String ?message;
 UpdateProfileData ?data;
 UpdateProfileModel.fromJason(dynamic json){
   status=json['status'];
   message=json['message'];
   data=json['data']!=null?UpdateProfileData.fromJason(json['data']):null;
 }
}
class UpdateProfileData{
  int ?id;
  String ?name;
  String ?email;
  String ?phone;
  UpdateProfileData.fromJason(dynamic json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
  }
}