extension DateTimeExtensions on DateTime {
  DateTime get fromFirestoreTimestamp =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}
