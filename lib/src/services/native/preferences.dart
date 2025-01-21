
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Preferences {

  static const platform = MethodChannel('com.djezzy.b2b.internet/native');

  static Future<bool> setMobileNumber(String token) async {
    print("setMobileNumber++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${platform.invokeMethod<bool>('Fb8c0bb41', {"msisdn": token})}");
    return await platform.invokeMethod<bool>('Fb8c0bb41', {"msisdn": token}) ?? false;
  }

  static Future<String?> getMobileNumber() async {
    print("getMobileNumber+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<String>('Fb8c0bb40')}");
    return await platform.invokeMethod<String>('Fb8c0bb40');
  }

  static Future<bool> setAccessToken(String token) async {
    print("setAccessToken+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<bool>('Fb8c0bb43', {"token": token})}");
    return await platform.invokeMethod<bool>('Fb8c0bb43', {"token": token}) ?? false;
  }

  static Future<String?> getAccessToken() async {
    print("getAccessToken++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<String>('Fb8c0bb42')}");
    return await platform.invokeMethod<String>('Fb8c0bb42');
  }

  static Future<bool> setRefreshToken(String token) async {
    print("setRefreshToken+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<bool>('Fb8c0bb45', {"token": token})}");
    return await platform.invokeMethod<bool>('Fb8c0bb45', {"token": token}) ?? false;
  }

  static Future<String?> getRefreshToken() async {
    print("getRefreshToken++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<String>('Fb8c0bb44')}");
    return await platform.invokeMethod<String>('Fb8c0bb44');
  }

  static Future<bool> setTokenType(String token) async {
    print("setTokenType+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<bool>('Fb8c0bb47', {"type": token})}");
    return await platform.invokeMethod<bool>('Fb8c0bb47', {"type": token}) ?? false;
  }

  static Future<String?> getTokenType() async {
    print("getTokenType++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<String>('Fb8c0bb46')}");
    return await platform.invokeMethod<String>('Fb8c0bb46');
  }

  static Future<bool> setLocale(String locale) async {
    print("setLocale+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<bool>('Fb8c0bb49', {"locale": locale})}");
    return await platform.invokeMethod<bool>('Fb8c0bb49', {"locale": locale}) ?? false;
  }

  static Future<String?> getLocale() async {
    print("getLocale++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${ await platform.invokeMethod<String>('Fb8c0bb48')}");
    return await platform.invokeMethod<String>('Fb8c0bb48');
  }

  static Future<bool> set(String key, Object value) async {
    print("set+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<bool>('set',  {"key": key, "value": value})}");
    return await platform.invokeMethod<bool>('set',  {"key": key, "value": value}) ?? false;
  }

  static Future<String?> get(String key) async {
    print("get++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${await platform.invokeMethod<String>('get', {"key": key})}");
    return await platform.invokeMethod<String>('get', {"key": key});
  }
}
