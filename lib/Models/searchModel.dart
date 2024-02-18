class SearchModel{
  bool ?status;
  Data ?data;
  SearchModel.fromJason(dynamic json){
    status=json['status'];
    data =json['data']!=null?Data.fromJason(json['data']):null;
  }
}
class Data{
List<SearchResult> data=[];
Data.fromJason(dynamic json){
  json['data'].forEach((element){
    data.add(SearchResult.fromJason(element));
  });
}
}
class SearchResult{
  int ?id;
  dynamic price;
  String ?image;
  String ?name;
  String ?description;
  bool?inFavorite;
  bool?inCart;
  SearchResult.fromJason(dynamic json){
    id=json['id'];
    price=json['price'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    inFavorite=json['in_favorites'];
    inCart=json['in_cart'];
  }
}