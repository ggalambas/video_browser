import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_browser/config/constants.dart';
import 'package:video_browser/models/video.dart';
import 'package:video_browser/pages/video/components/comments_related_section.dart';
import 'package:video_browser/pages/video/components/info_section.dart';
import 'package:video_browser/pages/video/components/player_controls.dart';
import 'package:video_browser/pages/video/components/section.dart';
import 'package:video_browser/widgets/background.dart';
import 'package:video_browser/widgets/player.dart';
import 'package:video_browser/widgets/tap_to.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  static String route = '/video';

  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final video = ModalRoute.of(context)!.settings.arguments as Video;
  late final videoController = VideoPlayerController.asset(video.path)
    ..initialize().then((_) => setState(() {}));

  bool isFullScreen = false;

  var lastSection = Section.comments;
  var _section = Section.comments;
  Section get section => _section;
  set section(Section newSection) => setState(() {
        lastSection = _section;
        _section = newSection;
      });

  final commentController = TextEditingController();
  String lastComment = '';
  String get comment => commentController.text;

  ThemeData get theme => Theme.of(context);

  @override
  void initState() {
    super.initState();
    commentController.addListener(() {
      if ((lastComment.isEmpty && comment.isNotEmpty) ||
          lastComment.isNotEmpty && comment.isEmpty) setState(() {});
      lastComment = comment;
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => videoController.play(),
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    commentController.dispose();
    super.dispose();
  }

  void addComment() {
    video.addComment(comment);
    commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return TapTo.unfocus(
      child: Background(
        child: Scaffold(
          body: isFullScreen
              ? videoPlayer
              : SafeArea(
                  child: Column(
                    children: [
                      videoPlayer,
                      Expanded(
                        child: SingleChildScrollView(
                          child: section.isInfo
                              ? InfoSection(
                                  video,
                                  expanded: true,
                                  onTap: () => section = lastSection,
                                )
                              : Column(
                                  children: [
                                    InfoSection(
                                      video,
                                      onTap: () => section = Section.info,
                                    ),
                                    const SizedBox(height: 8),
                                    const Divider(height: kDividerThickness),
                                    CommentsRelatedSection(
                                      video,
                                      section: section,
                                      onChanged: (s) => section = s,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      if (section.isComments) commentField,
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget get videoPlayer => Player(
        tag: video.key,
        aspectRatio:
            isFullScreen ? MediaQuery.of(context).size.aspectRatio : null,
        controller: videoController,
        overlays: [
          Positioned.fill(
            child: PlayerControls(
              controller: videoController,
              fullScreen: isFullScreen,
              onFullScreenChanged: (fullScreen) {
                // TODO Overflowing when leaving fullscreen
                setState(() => isFullScreen = fullScreen);
                SystemChrome.setPreferredOrientations([
                  fullScreen
                      ? DeviceOrientation.landscapeLeft
                      : DeviceOrientation.portraitUp
                ]);
              },
            ),
          ),
          Positioned.fill(
            top: null,
            child: VideoProgressIndicator(
              videoController,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: theme.primaryColor,
                bufferedColor: Colors.white54,
              ),
            ),
          ),
        ],
      );

  Widget get commentField => Column(
        children: [
          const Divider(height: kDividerThickness),
          Container(
            constraints: const BoxConstraints(
              minHeight: kBottomNavigationBarHeight,
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: commentController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                suffixIcon: comment.isEmpty
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(right: kInputPadding),
                        child: IconButton(
                          onPressed: addComment,
                          iconSize: kSmallIconSize,
                          icon: const Icon(Icons.send_outlined),
                        ),
                      ),
              ),
            ),
          ),
        ],
      );
}
