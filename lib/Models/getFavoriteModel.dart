class GetFavoriteModel{
  bool ?status;
  Data ?data;
  GetFavoriteModel.fromJason(dynamic json){
    status=json['json'];
    data=json['data']!=null?Data.fromJason(json['data']):null;
  }
}
class Data{
  List<InsideData> data=[];
  Data.fromJason(dynamic json){
    json['data'].forEach((e){
      data.add(InsideData.fromJason(e));
    });
  }
}
class InsideData{
  int ?id;
  Product ?product;
  InsideData.fromJason(dynamic json){
    id=json['id'];
    product=Product.fromJason(json['product']);
  }
}
class Product{
  int ?id;
  dynamic ?price;
  dynamic ?oldPrice;
  dynamic ?discount;
  String ?image;
  String ?name;
  String ?description;
  Product.fromJason(dynamic json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}
