
enum TrafficType {
  onnet,
  offnet,
  roaming,
  national,
  international,
  other;

  static TrafficType get(String? value){
    try {
      return TrafficType.values.byName(value ?? "");
    } catch (e) {
      return TrafficType.other;
    }
  }
}