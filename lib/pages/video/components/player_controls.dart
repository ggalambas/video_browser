import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_browser/config/constants.dart';
import 'package:video_browser/config/extensions.dart';
import 'package:video_player/video_player.dart';

class PlayerControls extends StatefulWidget {
  final VideoPlayerController controller;
  final bool fullScreen;
  final ValueChanged<bool> onFullScreenChanged;

  const PlayerControls({
    super.key,
    required this.controller,
    this.fullScreen = false,
    required this.onFullScreenChanged,
  });

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  bool showingControls = false;
  Timer? futureToggle;

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

  void toggleControls() {
    futureToggle?.cancel();
    if (mounted) {
      setState(() => showingControls = !showingControls);
    }
    if (showingControls) {
      futureToggle = Timer(const Duration(seconds: 3), toggleControls);
    }
  }

  void play() {
    controller.play();
    toggleControls();
  }

  void pause() {
    controller.pause();
    futureToggle?.cancel();
  }

  void skipBackward() => controller
      .seekTo(controller.value.position - const Duration(seconds: 15));
  void skipForward() => controller
      .seekTo(controller.value.position + const Duration(seconds: 15));
  void changeFullScreen() => widget.onFullScreenChanged(!widget.fullScreen);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleControls,
      child: Material(
        child: Stack(
          children: !showingControls
              ? []
              : [
                  Positioned.fill(child: Container(color: Colors.black38)),
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: skipBackward,
                          icon: const Icon(Icons.skip_previous),
                        ),
                        controller.value.isPlaying
                            ? IconButton(
                                onPressed: pause,
                                iconSize: 48,
                                icon: const Icon(Icons.pause),
                              )
                            : IconButton(
                                onPressed: play,
                                iconSize: 48,
                                icon: const Icon(Icons.play_arrow),
                              ),
                        IconButton(
                          onPressed: skipForward,
                          icon: const Icon(Icons.skip_next),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: null,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: kPagePadding),
                        Text(
                          '${controller.value.position.time} / ${controller.value.duration.time}',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: changeFullScreen,
                          icon: widget.fullScreen
                              ? const Icon(Icons.fullscreen_exit_outlined)
                              : const Icon(Icons.fullscreen_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
