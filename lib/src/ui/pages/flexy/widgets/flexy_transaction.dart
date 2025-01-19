import 'package:business/src/controllers/flexy/flexy_controller.dart';
import 'package:business/src/models/enums/transaction_status.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:business/src/models/il/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexyTransaction extends StatelessWidget {
  const FlexyTransaction({super.key, this.transaction});
  final Transaction? transaction;

  IconData _getStatus(TransactionStatus s) {
    switch (s) {
      case TransactionStatus.done:
        return Icons.check_circle;
      case TransactionStatus.failed:
        return Icons.cancel;
      case TransactionStatus.pending:
        return Icons.pending;
      default:
        return Icons.question_mark_sharp;
    }
  }

  Color _getColor(TransactionStatus s) {
    switch (s) {
      case TransactionStatus.done:
        return Colors.lightGreen;
      case TransactionStatus.failed:
        return Colors.red[200]!;
      case TransactionStatus.pending:
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: const [
          BoxShadow(
              blurRadius: 5,
              spreadRadius: 0.0,
              offset: Offset(1, 1),
              color: Colors.black26,
              blurStyle: BlurStyle.normal),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            _getStatus(transaction!.status!),
            size: 40,
            color: _getColor(transaction!.status!),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction!.receiver!,
                style: Get.theme.primaryTextTheme.displayMedium
                    ?.copyWith(fontSize: 13),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GetBuilder<FlexyController>(
                        builder: (ctrl) => Icon(
                          transaction!.sender == ctrl.msisdn
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: transaction!.sender == ctrl.msisdn
                              ? Colors.red[600]
                              : Colors.lightGreen,
                        ),
                      ),
                      Text(
                        '${transaction!.amount!}${transaction!.usageUnit!.format()}',
                        style: Get.theme.primaryTextTheme.displayMedium
                            ?.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                  Text(
                    transaction!.date!.toString().substring(0, 10),
                    style: Get.theme.primaryTextTheme.displayMedium
                        ?.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
