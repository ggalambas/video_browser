import 'dart:math';

import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:random_date/random_date.dart';
import 'package:video_browser/models/comment.dart';
import 'package:video_browser/models/sport.dart';
import 'package:video_browser/models/user.dart';
import 'package:video_browser/models/video.dart';

abstract class VideoManager {
  static List<Video> videos = [];
  static List<Video> videosOf(Sport? sport) => sport == null
      ? videos
      : videos.where((video) => video.sport == sport).toList();
  static List<Video> videosRelatedWith(Video video) => videos
      .where((v) =>
          v != video &&
          (v.sport == video.sport ||
              video.tags.any((tag) => v.tags.contains(tag)) ||
              v.coach == video.coach))
      .toList();

  static void generateVideos() {
    final random = Random();
    final count = Sport.values.length * 15;
    videos = List.generate(
      count,
      (_) => Video(
        'assets/example/video.mp4',
        title: lorem(paragraphs: 1, words: 5 + random.nextInt(5)),
        description: lorem(paragraphs: 2, words: 60),
        sport: Sport.values[random.nextInt(Sport.values.length)],
        uploadDate: RandomDate.withStartYear(2016).random(),
        tags: List.generate(
          3 + random.nextInt(4),
          (_) => lorem(paragraphs: 1, words: 1).replaceAll('.', ''),
        ),
        coach: User.random(),
        comments: List.generate(
          random.nextInt(100),
          (_) => Comment(
            User.random(),
            lorem(paragraphs: 1, words: 5 + random.nextInt(15)),
            RandomDate.withStartYear(2016).random(),
          ),
        )..sort(),
      ),
    );
  }
}
