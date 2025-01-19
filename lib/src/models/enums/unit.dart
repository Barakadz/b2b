enum Unit {
  tb,
  gb,
  mb,
  da,
  pieces,
  minutes,
  hours,
  days,
  weeks,
  months,
  bill_period,
  none;

  static Unit get(String? value) {
    try {
      return Unit.values.byName(value ?? "");
    } catch (e) {
      return Unit.none;
    }
  }
}

extension UnitEx on Unit {
  String format() {
    switch (this) {
      case Unit.tb:
        return "To";
      case Unit.gb:
        return "Gb";
      case Unit.mb:
        return "Mb";
      case Unit.da:
        return "DA";
      case Unit.pieces:
        return "SMS";
      case Unit.minutes:
        return "Min";
      case Unit.hours:
        return "Hrs";
      case Unit.days:
        return "Days";
      case Unit.weeks:
        return "Weeks";
      case Unit.months:
        return "Months";
      default:
        return "";
    }
  }
}
