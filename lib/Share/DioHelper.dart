import 'package:dio/dio.dart';
class DioHelper{

  static  Dio ?dio;
  static initialDioHelper(){
     dio=Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  //get
  static Future getData({
    required String url,
    dynamic ?data,
    String ?Authorization,
    Map<String,dynamic> ?query,
})async{
    dio!.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':Authorization,
    };
    return await dio!.get(
        url,
      data: data,
      queryParameters: query,
    );
  }

  //post
  static Future postData({
    required String url,
    dynamic ?data,
    String ?Authorization,
    Map<String,dynamic> ?query,
  })async{
    dio!.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':Authorization,
    };
    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  //put
  static Future putData({
    required String url,
    dynamic ?data,
    String ?Authorization,
    Map<String,dynamic> ?query,
  })async{
    dio!.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':Authorization,
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}