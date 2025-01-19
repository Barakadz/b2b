import 'package:business/src/controllers/invoices_controller.dart';
import 'package:business/src/ui/pages/invoices/widgets/invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceList extends StatelessWidget {
  const InvoiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<InvoicesCtrl>(
          builder: (ctrl) => ListView.builder(
              itemCount: ctrl.invoices.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {},
                  child: Container(
                    //height: 60,
                    child: InvoiceCard(invoice: ctrl.invoices.elementAt(index)),
                  ),
                );
              })),
    );
  }
}
