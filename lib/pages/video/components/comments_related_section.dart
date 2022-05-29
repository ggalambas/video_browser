import 'package:flutter/material.dart';
import 'package:video_browser/config/constants.dart';
import 'package:video_browser/models/video.dart';
import 'package:video_browser/pages/video/components/comment_tile.dart';
import 'package:video_browser/pages/video/components/section.dart';
import 'package:video_browser/video_manager.dart';
import 'package:video_browser/widgets/video_tile.dart';

class CommentsRelatedSection extends StatelessWidget {
  final Video video;
  final Section section;
  final ValueChanged<Section> onChanged;

  const CommentsRelatedSection(
    this.video, {
    super.key,
    required this.section,
    required this.onChanged,
  });

  List<Video> get relatedVideos => VideoManager.videosRelatedWith(video);
  double videoTileWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth - kPagePadding) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [commentsButton(context), relatedVideosButton(context)],
          ),
        ),
        if (section.isComments) ...comments,
        // TODO Videos are not loading
        if (section.isRelatedVideos)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPagePadding / 2),
            child: Wrap(
              children: [
                for (final video in relatedVideos)
                  SizedBox(
                    width: videoTileWidth(context),
                    child: VideoTile(video, compact: true),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget commentsButton(BuildContext context) => TextButton(
        onPressed: () => onChanged(Section.comments),
        child: Text(
          'Comments (${video.comments.length})',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: section.isComments ? null : Colors.white54,
              ),
        ),
      );

  Widget relatedVideosButton(BuildContext context) => TextButton(
        onPressed: () => onChanged(Section.relatedVideos),
        child: Text(
          'Related Videos',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: section.isRelatedVideos ? null : Colors.white54,
              ),
        ),
      );

  List<Widget> get comments =>
      video.comments.map((comment) => CommentTile(comment)).toList();
}
