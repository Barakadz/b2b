
enum TransactionStatus {
  done,
  initiated,
  pending,
  failed,
  none;

  static TransactionStatus get(String? value){
    try {
      return TransactionStatus.values.byName(value ?? "");
    } catch (e) {
      return TransactionStatus.none;
    }
  }
}

/*public static String format(Context context, Type type) {
    switch (type){
      case data:
        return context.getString(R.string.display_package_data);
      case money:
        return context.getString(R.string.display_package_voice);
      default:
        return "";
    }
  }

  public static String toString(Type type) {
    switch (type){
      case data:
        return DATA_SHARE_KEY;
      case money:
        return CREDIT_SHARE_KEY;
      case scratch:
        return SCRATCH_CARD_KEY;
      case family:
        return FAMILY_SHARE_KEY;
      default:
        return "";
    }
  }*/