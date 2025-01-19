
import 'package:business/src/models/base_model.dart';
import 'package:business/src/helpers/text_helper.dart';
import 'package:business/src/models/enums/invoice_status.dart';

class Invoice extends BaseModel {

    final InvoiceStatus? status;
    final double? total;
    final double? totalVat;
    final double? paidAmount;
    final dynamic fromDate;
    final dynamic toDate;
    final dynamic dueDate;

    Invoice({
        super.id,
        super.type,
        this.status,
        this.total,
        this.totalVat,
        this.paidAmount,
        this.fromDate,
        this.toDate,
        this.dueDate,
    });//

    factory Invoice.fromJson(Map<String, dynamic> json) {
        var baseModel = BaseModel.fromJson(json);
        var tmp = Invoice(
            id: baseModel.id,
            type: baseModel.type,
            status: InvoiceStatus.get(json['attributes']['payment-status']),
            total: TextHelper.getDouble(json['attributes']['total']),
            totalVat: TextHelper.getDouble(json['attributes']['total-without-vat']),
            paidAmount: TextHelper.getDouble(json['attributes']['payment-amount']),
            dueDate: TextHelper.getDate(json['attributes']['due-date'], TextHelper.randomFormat),
            toDate: TextHelper.getDate(json['attributes']['billing-period-to'], TextHelper.randomFormat),
            fromDate: TextHelper.getDate(json['attributes']['billing-period-from'], TextHelper.randomFormat),
        );
        return tmp;
    }
}
