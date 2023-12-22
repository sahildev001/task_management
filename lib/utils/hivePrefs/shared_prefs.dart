import 'package:hive/hive.dart';

import 'package:task_management/utils/log.dart';

class SharedPreferences {
  static const _preferencesBox = '_preferencesBox';
  final Box<dynamic> _box;

  SharedPreferences._(this._box);

  static Future<SharedPreferences> getInstance() async {
    final box = await Hive.openBox<dynamic>(_preferencesBox);
    return SharedPreferences._(box);
  }

  String? getString(Object key) {
    return _box.get(key) as String?;
  }

  Future<dynamic> setString(dynamic key, String value) async {
  await   _box.delete(key);
    return  _box.put(key, value);
  }

  int? getInt(Object key) {
    return _box.get(key) as int?;
  }

  Future<dynamic> setInt(dynamic key, int value) async {
    await _box.delete(key);
    return  _box.put(key, value);
  }

  bool? getBool(Object key) {
    return _box.get(key) as bool?;
  }

  Future<dynamic> setBool(dynamic key, bool value) async {
    await _box.delete(key);
    return  _box.put(key, value);
  }

  double? getDouble(Object key) {
    return _box.get(key) as double?;
  }

  Future<dynamic> setDouble(dynamic key, double value) async {
   await _box.delete(key);
    return  _box.put(key, value);
  }

  T? getValueOrNull<T>(Object key) {
    return _box.get(key) as T?;
  }

  T getValue<T>(dynamic key, {required T defaultValue}) {
    return _box.get(key, defaultValue: defaultValue) as T;
  }

  Future<void> setValue<T>(dynamic key, T value) async {
    _box.delete(key);
    return await _box.put(key, value);
  }

  void clear() {
    Hive.box<dynamic>(_preferencesBox).clear();
  }

  // void clearIndividualKeys() {
  //   _box.delete(AppUserPrefKeys.user_role);
  //   _box.delete(AppUserPrefKeys.token);
  //   _box.delete(AppUserPrefKeys.fcm_token);
  //   _box.delete(AppUserPrefKeys.font_code);
  //   _box.delete(AppUserPrefKeys.header_color_center);
  //   _box.delete(AppUserPrefKeys.header_color_left);
  //   _box.delete(AppUserPrefKeys.header_color_right);
  //   _box.delete(AppUserPrefKeys.primary_color_code);
  //   _box.delete(AppUserPrefKeys.privacy_policy_url);
  //   _box.delete(AppUserPrefKeys.agency_logo);
  //   _box.delete(AppUserPrefKeys.competency_image);
  //   _box.delete(AppUserPrefKeys.course_image);
  //   _box.delete(AppUserPrefKeys.field_visit_image);
  //   _box.delete(AppUserPrefKeys.course_response_model);
  //   _box.delete(AppUserPrefKeys.competency_response_model);
  //   _box.delete(AppUserPrefKeys.login_response);
  // }

  void clearKey({required String key}) {
    try {
      _box.delete(key);
    }catch(e){
      Log.printError(error: "shared_prefrences error on clear key($key) $e", filename: "shared_prefrences");
    }
  }
}
