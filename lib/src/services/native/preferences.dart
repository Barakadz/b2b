
import 'package:flutter/services.dart';

class Preferences {

  static const platform = MethodChannel('com.djezzy.b2b.internet/native');

  static Future<bool> setMobileNumber(String token) async {
    return await platform.invokeMethod<bool>('Fb8c0bb41', {"msisdn": token}) ?? false;
  }

  static Future<String?> getMobileNumber() async {
    return await platform.invokeMethod<String>('Fb8c0bb40');
  }

  static Future<bool> setAccessToken(String token) async {
    return await platform.invokeMethod<bool>('Fb8c0bb43', {"token": token}) ?? false;
  }

  static Future<String?> getAccessToken() async {
    return await platform.invokeMethod<String>('Fb8c0bb42');
  }

  static Future<bool> setRefreshToken(String token) async {
    return await platform.invokeMethod<bool>('Fb8c0bb45', {"token": token}) ?? false;
  }

  static Future<String?> getRefreshToken() async {
    return await platform.invokeMethod<String>('Fb8c0bb44');
  }

  static Future<bool> setTokenType(String token) async {
    return await platform.invokeMethod<bool>('Fb8c0bb47', {"type": token}) ?? false;
  }

  static Future<String?> getTokenType() async {
    return await platform.invokeMethod<String>('Fb8c0bb46');
  }

  static Future<bool> setLocale(String locale) async {
    return await platform.invokeMethod<bool>('Fb8c0bb49', {"locale": locale}) ?? false;
  }

  static Future<String?> getLocale() async {
    return await platform.invokeMethod<String>('Fb8c0bb48');
  }

  static Future<bool> set(String key, Object value) async {
    return await platform.invokeMethod<bool>('set',  {"key": key, "value": value}) ?? false;
  }

  static Future<String?> get(String key) async {
    return await platform.invokeMethod<String>('get', {"key": key});
  }
}
