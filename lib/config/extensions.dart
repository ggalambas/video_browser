extension DurationX on Duration {
  String get time =>
      toString().split('.').first.split(':').sublist(1, 3).join(':');
}
