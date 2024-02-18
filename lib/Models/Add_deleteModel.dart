class EditFavorite{
  bool ?status;
  String ?message;
  favoriteData ?data;
  EditFavorite.fromJason(dynamic json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?favoriteData.fromJason(json['data']):null;
  }
}
class favoriteData{
  dynamic ?id;
  Products ?products;
  favoriteData.fromJason(dynamic json){
    id=json['id'];
    products=Products.fromJason(json['product']);
  }
}
class Products{
  dynamic ?id;
  dynamic ?price;
  dynamic ?old_price;
  dynamic ?discount;
  dynamic ?image;
  Products.fromJason(dynamic json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
  }
}