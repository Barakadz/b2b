import 'package:business/src/assets/colors.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:business/src/controllers/flexy/flexy_controller.dart';
import 'package:business/src/models/enums/transaction_status.dart';
import 'package:business/src/models/il/Transaction.dart';

class FlexyTransaction extends StatelessWidget {
  const FlexyTransaction({Key? key, this.transaction}) : super(key: key);
  final Transaction? transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildStatusIcon(),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTransactionDetails(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    final status = transaction!.status!;
    return Container(
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(12),
      child: Icon(
        _getStatusIcon(status),
        size: 40,
        color: _getStatusColor(status),
      ),
    );
  }

  Widget _buildTransactionDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              transaction!.receiver!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            _buildTransactionTypeIcon(),
          ],
        ),
        const SizedBox(height: 8),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.network_check_outlined,
                  color: Colors.green[500],
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '${transaction!.amount!} ${transaction!.usageUnit!.format()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey[600],
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  transaction!.date!.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionTypeIcon() {
    return GetBuilder<FlexyController>(
      builder: (ctrl) => Icon(
        transaction!.sender == ctrl.msisdn
            ? Icons.upload_rounded
            : Icons.download_rounded,
        color: transaction!.sender == ctrl.msisdn
            ? Colors.red[600]
            : Colors.green[600],
        size: 24,
      ),
    );
  }

  IconData _getStatusIcon(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.done:
        return Icons.check_circle_rounded;
      case TransactionStatus.failed:
        return Icons.cancel_rounded;
      case TransactionStatus.pending:
        return Icons.hourglass_bottom_rounded;
      default:
        return Icons.help_rounded;
    }
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.done:
        return Colors.green;
      case TransactionStatus.failed:
        return CustomColors.secondaryColor;
      case TransactionStatus.pending:
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }
}