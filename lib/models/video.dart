import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_browser/models/comment.dart';
import 'package:video_browser/models/sport.dart';
import 'package:video_browser/models/user.dart';

class Video {
  final Key key = UniqueKey();
  final String path;
  final String title;
  final String description;
  final Sport sport;
  final DateTime uploadDate;
  final List<String> tags;
  final User coach;
  final List<Comment> comments;

  Video(
    this.path, {
    required this.title,
    required this.description,
    required this.sport,
    required this.uploadDate,
    required this.tags,
    required this.coach,
    required this.comments,
  });

  String get uploadDateAgo => timeago.format(uploadDate);

  void addComment(String comment) => comments.insert(
        0,
        Comment(User.me(), comment, DateTime.now()),
      );
}
