class LogoutModel{
  bool ?status;
  String ?message;
  Data ?data;
  LogoutModel.fromJason(dynamic json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?Data.fromJason(json['data']):null;
  }
}
class Data{
  int ?id;
  String ?token;
  Data.fromJason(dynamic json){
    id=json['id'];
    token=json['token'];
  }
}