import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass{
  final String isLoginKeyString = "isLoginKey";
  final String emailKey = "emailKey";
  final String passwordKey = "passwordKey";

  Future<bool> saveIsLogin(bool isLogin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(isLoginKeyString, isLogin);
  }

  Future<bool?> getIsLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isLoginKeyString);
  }

  Future<bool> removeIsLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(isLoginKeyString);
  }


    Future<bool> saveEmail(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(emailKey, email);
  }

  Future<String?> getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(emailKey);
  }

  Future<bool> removeEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(emailKey);
  }

    Future<bool> savePassword(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(passwordKey, email);
  }

  Future<String?> getPassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(passwordKey);
  }

  Future<bool> removePassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(passwordKey);
  }



}