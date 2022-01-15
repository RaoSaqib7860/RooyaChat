import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';

import 'PageManager.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String? url;

  const CustomAudioPlayer({Key? key, this.url}) : super(key: key);

  @override
  _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager(path: widget.url);
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Transform.translate(
            offset: Offset(0, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<ButtonState>(
                      valueListenable: _pageManager.buttonNotifier,
                      builder: (_, value, __) {
                        switch (value) {
                          case ButtonState.loading:
                            return Container(
                              width: 48.0,
                              child: Center(
                                  child: Transform.translate(
                                offset: Offset(0, -5),
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    child: const CircularProgressIndicator()),
                              )),
                            );
                          case ButtonState.paused:
                            return Transform.translate(
                                offset: Offset(0, -6),
                                child: IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  iconSize: 28.0,
                                  onPressed: _pageManager.play,
                                ));
                          case ButtonState.playing:
                            return Transform.translate(
                                offset: Offset(0, -6),
                                child: IconButton(
                                  icon: const Icon(Icons.pause),
                                  iconSize: 28.0,
                                  onPressed: _pageManager.pause,
                                ));
                        }
                      },
                    ),
                    Expanded(
                      child: ValueListenableBuilder<ProgressBarState>(
                        valueListenable: _pageManager.progressNotifier,
                        builder: (_, value, __) {
                          return ProgressBar(
                            progress: value.current,
                            buffered: value.buffered,
                            total: value.total,
                            onSeek: _pageManager.seek,
                            thumbRadius: 7,
                            barHeight: 2,
                            timeLabelTextStyle:
                                TextStyle(color: Colors.black26, fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
