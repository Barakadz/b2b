
enum PaymentType {
  hybrid,
  prepaid,
  postpaid,
  other;

  static PaymentType get(String? value){
    try {
      return PaymentType.values.byName(value ?? "");
    } catch (e) {
      return PaymentType.other;
    }
  }
}
