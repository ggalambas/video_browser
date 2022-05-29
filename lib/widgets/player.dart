import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Player extends StatelessWidget {
  final Object tag;
  final double? aspectRatio;
  final VideoPlayerController controller;
  final List<Widget>? overlays;

  const Player({
    super.key,
    required this.tag,
    this.aspectRatio,
    required this.controller,
    this.overlays,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.black)),
          AspectRatio(
            aspectRatio: aspectRatio ?? 16 / 9,
            child: controller.value.isInitialized
                ? Center(
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  )
                : const SizedBox(),
          ),
          ...?overlays,
        ],
      ),
    );
  }
}
