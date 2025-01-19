enum ClickAction {
  reloadFaq,
  reloadTransactions,
  reloadInvoices,
  reloadOffers,
  reloadCompanies,
  none;

  static ClickAction get(String? value) {
    try {
      return ClickAction.values.byName(value ?? "");
    } catch (e) {
      return ClickAction.none;
    }
  }
}
