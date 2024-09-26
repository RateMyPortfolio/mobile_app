import 'package:shared_preferences/shared_preferences.dart';

class SHDFClass {
  ////read String Value
  static Future<String?> readStringValue(String name, String defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.getString(name);
  }

  ///save String Value
  static saveStringValue(String name, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString(name, value);
  }

  ///----------------------------------------------------------------------

  /////save List String Value
  static saveListStringValue(String name, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.setStringList(name, value);
  }

  ///read List String Value
  static Future<List<String>?> readListStringValue(String name, String defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getStringList(name);
  }
/////-------------------------------------------------

  ///save Boolean Value
  static saveBooleanValue(String name, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setBool(name, value);
  }

  ///  read Boolean Value
  static Future readBooleanValue(String name, String defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.getBool(name);
  }
/////-------------------------------------------------

  static saveIntValue(String name, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setInt(name, value);
  }

  static Future readIntValue(String name, int defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.getInt(name);
  }

/////-------------------------------------------------

  static clearPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.clear();
  }

  static void saveSharedPrefValueBoolean(session, bool bool) {}
}
