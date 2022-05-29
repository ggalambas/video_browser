import 'package:timeago/timeago.dart' as timeago;
import 'package:video_browser/models/user.dart';

class Comment implements Comparable<Comment> {
  final User user;
  final String text;
  final DateTime date;
  Comment(this.user, this.text, this.date);

  String get dateAgo => timeago.format(date);

  @override
  String toString() => text;

  @override
  int compareTo(Comment other) => other.date.compareTo(date);
}
