
enum InvoiceStatus {

  unpaid,
  paid,
  none;

  static InvoiceStatus get(String? value){
    try {
      return InvoiceStatus.values.byName(value ?? "");
    } catch (e) {
      return InvoiceStatus.none;
    }
  }
}

extension InvoiceStatusEx on InvoiceStatus {
  String format() {
    switch (this){
      case InvoiceStatus.paid:
        return  "Paid";
      default:
        return "Unpaid";
    }
  }
}