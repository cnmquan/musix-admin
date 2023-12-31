import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// ignore: implementation_imports
import 'package:chewie/src/animated_play_pause.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    Key? key,
    required this.dataUrl,
  }) : super(key: key);
  final String dataUrl;
  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late ChewieController chewieController;
  bool isStartPlayingVideo = false;

  final barHeight = 48.0 * 1.5;

  Widget buildVideoPlayer() => Chewie(controller: chewieController);

  @override
  void initState() {
    setChewieVideo();
    super.initState();
  }

  setChewieVideo() async {
    chewieController = await buildChewieController(
      dataUrl: widget.dataUrl,
    );
    setState(() {
      isStartPlayingVideo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isStartPlayingVideo) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.lightGreen,
          ),
        ),
      );
    }
    return chewieController.videoPlayerController.value.isInitialized
        ? Container(
            color: Colors.black,
            height: 200,
            child: buildVideoPlayer(),
          )
        : const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.lightGreen,
              ),
            ),
          );
  }
}

Future<ChewieController> buildChewieController({
  required String dataUrl,
}) async {
  VideoPlayerController videoPlayerController =
      VideoPlayerController.networkUrl(Uri.parse(dataUrl));
  await videoPlayerController.initialize();
  return ChewieController(
      videoPlayerController: videoPlayerController,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.lightGreen,
        bufferedColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      allowFullScreen: true);
}

class CenterPlayButton extends StatelessWidget {
  const CenterPlayButton({
    Key? key,
    required this.backgroundColor,
    this.iconColor,
    required this.show,
    required this.isPlaying,
    required this.isFinished,
    this.onPressed,
  }) : super(key: key);

  final Color backgroundColor;
  final Color? iconColor;
  final bool show;
  final bool isPlaying;
  final bool isFinished;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Center(
        child: UnconstrainedBox(
          child: AnimatedOpacity(
            opacity: show ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              // Always set the iconSize on the IconButton, not on the Icon itself:
              // https://github.com/flutter/flutter/issues/52980
              child: IconButton(
                iconSize: 32,
                padding: const EdgeInsets.all(12.0),
                icon: isFinished
                    ? Icon(Icons.replay, color: iconColor)
                    : AnimatedPlayPause(
                        color: iconColor,
                        playing: isPlaying,
                      ),
                onPressed: onPressed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
