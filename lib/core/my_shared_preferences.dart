import 'dart:convert';

import 'package:cash_van_app/model/auth/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _sharedPreferences;

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void clearProfile() {
    isLogin = false;
  }

  Future<void> saveUserData(LoginModel loginResult) async {
    String loginModelJson = jsonEncode(loginResult.toJson());
    await _sharedPreferences.setString(keyUserData, loginModelJson);
  }

  LoginModel? getUserData() {
    String? loginModelJson = _sharedPreferences.getString(keyUserData);
    if (loginModelJson != null) {
      return LoginModel.fromJson(jsonDecode(loginModelJson));
    }
    return LoginModel.fromJson({});
  }

  Future<void> clearUserData() async {
    await _sharedPreferences.remove(keyUserData);
  }

  bool get isLogin => _sharedPreferences.getBool(keyIsLogin) ?? false;

  set isLogin(bool value) {
    _sharedPreferences.setBool(keyIsLogin, value);
  }

  bool get fingerPrint => _sharedPreferences.getBool(keyFingerPrint) ?? false;

  set fingerPrint(bool value) {
    _sharedPreferences.setBool(keyFingerPrint, value);
  }

  String get language => _sharedPreferences.getString(keyLanguage) ?? "en";

  set language(String value) {
    _sharedPreferences.setString(keyLanguage, value);
  }

  Color get colorApp {
    String? colorString = _sharedPreferences.getString(keyColorApp);
    return colorString != null
        ? Color(int.parse(colorString))
        : const Color(0xFF0D47A1);
  }

  set colorApp(Color value) {
    _sharedPreferences.setString(keyColorApp, value.value.toString());
  }

  String get ip => _sharedPreferences.getString(keyIP) ?? "";

  set ip(String value) {
    _sharedPreferences.setString(keyIP, value);
  }

  int get userId => _sharedPreferences.getInt(keyUserId) ?? 0;

  set userId(int value) {
    _sharedPreferences.setInt(keyUserId, value);
  }

  double get fontSize => _sharedPreferences.getDouble(keyFontSize) ?? 1.0;

  set fontSize(double value) {
    _sharedPreferences.setDouble(keyFontSize, value);
  }
}

final mySharedPreferences = MySharedPreferences();

const String keyFontSize = "key_font_size";
const String keyColorApp = "key_color_app";
const String keyUserData = "key_user_data";
const String keyIsLogin = "key_is_login";
const String keyFingerPrint = "key_finger_print";
const String keyIP = "key_ip";
const String keyLanguage = "key_language";
const String keyUserId = "key_user_id";
