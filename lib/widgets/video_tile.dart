import 'package:flutter/material.dart';
import 'package:video_browser/config/constants.dart';
import 'package:video_browser/config/extensions.dart';
import 'package:video_browser/models/video.dart';
import 'package:video_browser/pages/video/video_page.dart';
import 'package:video_browser/widgets/player.dart';
import 'package:video_player/video_player.dart';

class VideoNotification extends Notification {}

class VideoTile extends StatefulWidget {
  final Video video;
  final bool autoPlay;
  final bool compact;

  const VideoTile(
    this.video, {
    super.key,
    this.autoPlay = false,
    this.compact = false,
  });

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late final controller = VideoPlayerController.asset(widget.video.path)
    ..initialize().then((_) => setState(() {}))
    ..setVolume(0)
    ..setLooping(true);

  ThemeData get theme => Theme.of(context);

  void playPostFrame() => WidgetsBinding.instance.addPostFrameCallback(
        (_) => controller.play(),
      );

  void open() => Navigator.pushNamed(
        context,
        VideoPage.route,
        arguments: widget.video,
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autoPlay) playPostFrame();
    return InkWell(
      onTap: open,
      onLongPress: () =>
          controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Padding(
        padding: EdgeInsets.all(widget.compact ? kPagePadding / 2 : 0),
        child: Column(
          children: [
            Player(
              tag: widget.video.key,
              controller: controller,
              overlays: [
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: _TimeStamp(controller: controller),
                ),
              ],
            ),
            Padding(
              padding: widget.compact
                  ? const EdgeInsets.symmetric(vertical: 4)
                  : const EdgeInsets.symmetric(horizontal: kPagePadding)
                      .add(const EdgeInsets.only(top: 8, bottom: 16)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!widget.compact) ...[avatar, const SizedBox(width: 12)],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        SizedBox(height: widget.compact ? 2 : 4),
                        info,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get avatar => CircleAvatar(
        backgroundImage: AssetImage(widget.video.coach.photoUrl),
      );

  Widget get title => Text(
        widget.video.title,
        style: theme.textTheme.labelLarge!
            .copyWith(fontSize: widget.compact ? null : kTitleSize),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget get info => Text(
        '${widget.video.coach}${!widget.compact ? ' • ${widget.video.sport} • ${widget.video.uploadDateAgo}' : ''}',
        style: theme.textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
}

class _TimeStamp extends StatefulWidget {
  final VideoPlayerController controller;
  const _TimeStamp({required this.controller});

  @override
  State<_TimeStamp> createState() => __TimeStampState();
}

class __TimeStampState extends State<_TimeStamp> {
  void notify() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(notify);
  }

  @override
  void dispose() {
    controller.removeListener(notify);
    super.dispose();
  }

  ThemeData get theme => Theme.of(context);
  VideoPlayerController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        (controller.value.duration - controller.value.position).time,
        style: theme.textTheme.bodySmall,
      ),
    );
  }
}
