import 'package:get/get.dart';
import 'package:business/src/languages/ar.dart';
import 'package:business/src/languages/en.dart';
import 'package:business/src/languages/fr.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'ar': ar, 'fr': fr, 'en': en};
}
