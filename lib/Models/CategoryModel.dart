class CategoryModel{
  bool ?status;
  IntirnalData ?data;
  CategoryModel.fromJason(dynamic json){
    status=json['status'];
    data=json['data']!=null?IntirnalData.fromJason(json['data']):null;
  }
}
class IntirnalData{
  List<InsideData> ?data=[];
  IntirnalData.fromJason(dynamic json){
    json['data'].forEach((element){
      data?.add(InsideData.fromJason(element));
    });
  }
}
class InsideData{
  dynamic ?id;
  dynamic ?name;
  dynamic ?image;
  InsideData.fromJason(dynamic json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
  
}