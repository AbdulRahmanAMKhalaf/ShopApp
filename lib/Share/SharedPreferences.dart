import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{
  static SharedPreferences ?sharedPreferences;

  static Future initialCacheHelper()async{
     return sharedPreferences= await SharedPreferences.getInstance();
  }

  //set
    static Future setData({
    required String key,
      required dynamic value,
})async{
    if(value is String) return await sharedPreferences!.setString(key, value);
    else if(value is bool) return await sharedPreferences!.setBool(key, value);
    else if(value is int) return await sharedPreferences!.setInt(key, value);
    else if(value is double) return await sharedPreferences!.setDouble(key, value);
    else return await sharedPreferences!.setStringList(key, value);
    }

  //get
    static String ?getStringData({required String key}){
    return  sharedPreferences!.getString(key);
    }

  static bool? getBooleanData({required String key}){
    return  sharedPreferences!.getBool(key);
  }

  static int ?getIntegerData({required String key}){
    return  sharedPreferences!.getInt(key);
  }

  static double ?getDoubleData({required String key}){
    return  sharedPreferences!.getDouble(key);
  }

  static dynamic getStringListData({required String key}){
    return sharedPreferences!.getStringList(key)!;
  }
  static dynamic removeData({
    required String key,
}){
    return sharedPreferences!.remove(key);
  }
}