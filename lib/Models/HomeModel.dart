class HomeModel{
  bool ?status;
  String ?message;
  HomeData?data;
  HomeModel.fromJason(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?HomeData.fromJason(json['data']):null;
  }
}
class HomeData{
  List<BannerModel>?banners=[];
  List<ProductModel>?products=[];
  String ?ad;
  HomeData.fromJason(Map<String,dynamic> json){
    ad=json['ad'];
    json['banners']!.forEach((element) {
      banners!.add(BannerModel.fromJason(element));
    });
    json['products']!.forEach((element) {
      products!.add(ProductModel.fromJason(element));
    });
  }
}
class BannerModel{
  int ?id;
  String ?image;
  BannerModel.fromJason(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
  }

}
class ProductModel{
  int ?id;
  dynamic ?price;
  dynamic ?oldPrice;
  dynamic ?discount;
  String ?image;
  String ?name;
  String ?description;
  bool ?favorite;
  bool ?inCart;
  ProductModel.fromJason(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    discount=json['discount'];
    oldPrice=json['old_price'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    favorite=json['in_favorites'];
    inCart=json['in_cart'];
  }

}