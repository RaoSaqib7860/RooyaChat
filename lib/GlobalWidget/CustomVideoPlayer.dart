import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String? url;

  const CustomVideoPlayer({Key? key, this.url}) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  BetterPlayerController? betterPlayerController;

  @override
  void initState() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "${widget.url}",
    );
    betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          fit: BoxFit.contain,
          aspectRatio: 0.1,
          autoDetectFullscreenAspectRatio: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
              showControlsOnInitialize: false),
        ),
        betterPlayerDataSource: betterPlayerDataSource);
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child: BetterPlayer(
              controller: betterPlayerController!,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }
}
