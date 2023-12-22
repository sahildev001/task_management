import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:task_management/utils/hivePrefs/shared_prefs.dart';

import '../../webservices/models/login_result.dart';

class UserPrefs {
  factory UserPrefs() {
    return _singleton;
  }

  UserPrefs._internal();

  static final UserPrefs _singleton = UserPrefs._internal();

  late SharedPreferences _prefsInstance;

  final String _loginResponseKey = 'loginResponseKey';

  Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  void setString(String key, String value) {
    _prefsInstance.setString(key, value);
  }

  String getString(String key) {
    String? data = _prefsInstance.getString(key);
    if (data != null) {
      return data;
    }
    return "";
  }

  void setInt(String key, int value) {
    _prefsInstance.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefsInstance.getInt(key);
  }

  void setBool(String key, bool value) {
    _prefsInstance.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefsInstance.getBool(key);
  }

  void setDouble(String key, double value) {
    _prefsInstance.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefsInstance.getDouble(key);
  }


  Future<void> setLoginResponse({required LoginResult loginResult}) async {
    await _prefsInstance.setValue(_loginResponseKey,
        jsonEncode(loginResult.toJson()));
  }


  LoginResult? getLoginResponse(){
    final jsonData = _prefsInstance.getValueOrNull<String?>(_loginResponseKey);
    if (jsonData == null) {
      return null;
    } else {
      return LoginResult.fromJson(jsonDecode(jsonData) as Map<String,dynamic>);
    }
  }


}