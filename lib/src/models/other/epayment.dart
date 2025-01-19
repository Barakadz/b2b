class Epayment {
  static const String flexy = "RECHARGE";
  static const String payment = "INVOICE";
  static const String satim = "SATIM";
  static const String postOffice = "POSTOFFICE";
  static const String cib = "CIB";
  static const String poste = "DAHABIA";
  static const String epType = "type";
  static const String epOrderPayment = "order-payment";
  static const String epAttributes = "attributes";
  static const String epMsisdn = "payment-msisdn";
  static const String epPaymentType = "payment-type";
  static const String epService = "payment-service";
  static const String epCardType = "card-type";
  static const String epInvoiceId = "invoice-id";
  static const String epLanguage = "language";
  static const String epAmount = "amount";
  static const String epCurrency = "currency";
  static const String epDataKey = "data";
  static const String epOrderId = "order-id";
  static const String epFormUrl = "form-url";

  final String? type;
  final String? aParty;
  final String? bParty;
  String? msisdn;
  final String? paymentType;
  String? service;
  String? cardType;
  final String? invoiceId;
  final String? language;
  final double? amount;
  final String? currency;

  Epayment(
      {this.type,
      this.aParty,
      this.bParty,
      this.msisdn,
      this.paymentType,
      this.service,
      this.cardType,
      this.invoiceId,
      this.language,
      this.amount,
      this.currency});

  Map<String, dynamic> toJson() {
    return {
      "data": {
        epType: epOrderPayment,
        "attributes": {
          epMsisdn: msisdn,
          epPaymentType: paymentType,
          epService: service,
          epCardType: cardType,
          epInvoiceId: '',
          epLanguage: 'fr',
          epAmount: amount,
          epCurrency: 'DZD',
        }
      }
    };
  }
}
