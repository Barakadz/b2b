import 'package:flutter/services.dart';

class InformationRetriever {
  static const platform = MethodChannel('com.djezzy.b2b.internet/native');

  static Future<String> getBaseUrl() async {
    return await platform.invokeMethod<String>('Ffa442cd3') ?? "";
  }

  static Future<String?> getRegistrationUrl() async {
    return await platform.invokeMethod<String>('F48628b49');
  }

  static Future<String?> getTokenUrl() async {
    return await platform.invokeMethod<String>('Fe54a2fc7');
  }

  static Future<String?> getInfoUrl() async {
    return await platform.invokeMethod<String>('Fe0c2ae9e');
  }

  static Future<String?> getCareUrl() async {
    return await platform.invokeMethod<String>('Fccd83952');
  }

  static Future<String?> getP() async {
    return await platform.invokeMethod<String>('Fee12c08d');
  }

  /* Client secret */
  static Future<String?> getInfo1() async {
    return await platform.invokeMethod<String>('F94027e6f');
  }

  /* Client Id */
  static Future<String?> getInfo2() async {
    return await platform.invokeMethod<String>('F0ca8c48e');
  }

  /* smsotp */
  static Future<String?> getInfo3() async {
    return await platform.invokeMethod<String>('Ff07c6783');
  }

  /* Mobile grant */
  static Future<String?> getInfo4() async {
    return await platform.invokeMethod<String>('F49c4f779');
  }

  /* Open ID */
  static Future<String?> getInfo5() async {
    return await platform.invokeMethod<String>('F624ec337');
  }

  /* Open ID */
  static Future<String?> getInfo6() async {
    return await platform.invokeMethod<String>('Fe8ed80d7');
  }
}
