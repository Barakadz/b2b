import 'package:business/src/models/dbss/usage.dart';
import 'package:business/src/models/enums/unit.dart';

enum BundleType {
  sms,
  mms,
  none,
  data,
  money,
  credit,
  voice;

  static BundleType get(String? value) {
    try {
      return BundleType.values.byName(value ?? "");
    } catch (e) {
      return BundleType.none;
    }
  }
}

extension BundleTypeEx on BundleType {
  String format() {
    switch (this) {
      case BundleType.data:
        return "Internet";
      case BundleType.voice:
        return "Appels";
      case BundleType.money:
      case BundleType.credit:
        return "Crédit";
      case BundleType.sms:
        return "SMS";
      case BundleType.mms:
        return "MMS";
      default:
        return " ";
    }
  }

  Unit getUnit(Usage usage) {
    switch (usage.type) {
      case BundleType.data:
        return (usage.total ?? 0) >= 1048576
            ? Unit.tb
            : (usage.total ?? 0) >= 1024
                ? Unit.gb
                : Unit.mb;
      case BundleType.credit:
      case BundleType.money:
        return Unit.da;
      case BundleType.voice:
        return Unit.minutes;
      case BundleType.sms:
        return Unit.pieces;
      default:
        return Unit.none;
    }
  }
}
