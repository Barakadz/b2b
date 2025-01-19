
enum Status {
  idle,
  error,
  success,
  loading,
  stopped,
  starting,
}

enum Reason {
  idle,
  network,
  noBalance,
  accountBlocked,
  wrongPin,
  maxReached,
  notExist,
  notFound,
  notAllowed,
  notIllegible,
  notAuthorized,
  unknown,
  cancelled,
  blacklisted,
  incorrect, used, stolen,
}

class Pair {

  final Status status;
  final Reason reason;

  Pair(this.status, this.reason);

  @override
  String toString() => 'Pair[$status, $reason]';
}