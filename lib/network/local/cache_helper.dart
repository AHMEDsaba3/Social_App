import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance().whenComplete(() => print(
        '+++++++++++++++++++preferences initialized++++++++++++++++++++++'));
  }

  static dynamic getData({
    required String key,
  }) {
    return preferences?.get(key);
  }

  static Future<dynamic> saveData(
      {required String key, required dynamic value}) async {
    if(value is String) return await preferences?.setString(key, value);
    if(value is int) return await preferences?.setInt(key, value);
    if(value is bool) {
      print('saved');
      return await preferences?.setBool(key, value);
    } else
      return await preferences?.setDouble(key, value);
  }

  static Future<bool> removeData({required String key})async{
    return await preferences!.remove(key);
  }

}
