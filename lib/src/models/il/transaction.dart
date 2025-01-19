import 'package:business/src/models/il/name.dart';
import 'package:business/src/models/base_model.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:business/src/helpers/text_helper.dart';
import 'package:business/src/models/enums/transaction_type.dart';
import 'package:business/src/models/enums/transaction_status.dart';

class Transaction extends BaseModel {
  //private static final String SCRATCH_CARD_KEY = "ScratchCard";
  static var dataShareKey = "DataShared";
  //private static final String CREDIT_SHARE_KEY = "SharedCredit";
  //private static final String FAMILY_SHARE_KEY = "FamilyShare";

  /*
    enum Direction {
        in,
        out,
        none;

        public static boolean contains(String s) {
            for(Transaction.Direction direction:values())
                if (direction.name().equals(s))
                    return true;
            return false;
        }

        public static String toString(Context context, Direction direction) {
            switch (direction){
                case in:
                    return context.getString(R.string.display_transaction_received);
                case out:
                    return context.getString(R.string.display_transaction_send);
                default:
                    return "";
            }
        }
    }*/

  final Name? name;
  final String? code;
  final String? pin;
  final String? sender;
  final String? receiver;
  final String? amount;
  final DateTime? date;
  final dynamic direction;
  final double? price;
  final Unit? usageUnit;
  final TransactionStatus? status;
  final TransactionType? usageType;

  Transaction({
    super.id,
    super.type,
    this.name,
    this.code,
    this.pin,
    this.sender,
    this.receiver,
    this.status,
    this.amount,
    this.date,
    this.direction,
    this.price,
    this.usageType,
    this.usageUnit,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    var baseModel = BaseModel.fromJson(json);
    return Transaction(
      id: baseModel.id,
      type: baseModel.type,
      name: Name.fromJson(json['attributes']['name'] ?? []),
      sender: json['attributes']['received-from'] as String?,
      receiver: json['attributes']['sent-to'] as String?,
      usageType: TransactionType.get(json['attributes']['usage-type']),
      status: TransactionStatus.get(json['attributes']['status']),
      amount: json['attributes']['usage-amout'] as String?,
      date: TextHelper.getDate(
          json['attributes']['transaction-time'], TextHelper.iso8601Format),
      direction: json['attributes']['id'] as String?,
      price: TextHelper.getDouble(json['attributes']['price']),
      usageUnit: Unit.get(json['attributes']['usage-unit']),
    );
  }

  static List<Transaction> transactionsList(List<Map<String, dynamic>> json) {
    return json.map((e) => Transaction.fromJson(e)).toList();
  }
}
