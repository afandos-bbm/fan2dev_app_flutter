extension DateTimeExtensions on DateTime {
  DateTime get fromFirestoreTimestamp =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  String get toFormattedString => '${this.day}/${this.month}/${this.year}';
}
