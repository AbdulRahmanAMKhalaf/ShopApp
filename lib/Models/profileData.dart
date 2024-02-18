class ProfileModel{
  bool ?status;
  ProfileData ?data;
  ProfileModel.fromJason(dynamic json){
    status=json['status'];
    data=json['data']!=null?ProfileData.fromJason(json['data']):null;
  }
}
class ProfileData{
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  ProfileData.fromJason(dynamic json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
  }
}