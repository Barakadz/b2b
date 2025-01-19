
enum Category {
  mixed,
  data,
  surprise,
  roaming,
  flexy,
  flash,
  none,
  loan,
  extra,
  shake,
  family,
  postpaid;

  static Category get(String? value){
    try {
      return Category.values.byName(value ?? "");
    } catch (e) {
      return Category.none;
    }
  }
}