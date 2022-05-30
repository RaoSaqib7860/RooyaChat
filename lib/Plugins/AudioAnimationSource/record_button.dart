import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';
import 'package:vibration/vibration.dart';
import 'audio_bubble.dart';
import 'flow_shader.dart';
import 'lottie_animation.dart';
import 'package:record/record.dart' as record;

class RecordButton extends StatefulWidget {
  final Function()? recordStop;
  final Function()? RecordStart;
  const RecordButton({
    Key? key,
    required this.controller,
    this.recordStop,
    this.RecordStart,
  }) : super(key: key);

  final AnimationController controller;

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  static double size = height / 22;

  final double lockerHeight = 200;
  double timerWidth = 0;

  late Animation<double> buttonScaleAnimation;
  late Animation<double> timerAnimation;
  late Animation<double> lockerAnimation;

  DateTime? startTime;
  Timer? timer;
  String recordDuration = "00:00";

  bool isLocked = false;
  bool showLottie = false;

  @override
  void initState() {
    super.initState();
    buttonScaleAnimation = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticInOut),
      ),
    );
    widget.controller.addListener(() {
      if(mounted){
        setState(() {});
      }
    });
  }
 bool showBottomIcon=false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    timerWidth =
        MediaQuery.of(context).size.width - 2 * Globals.defaultPadding - 4;
    timerAnimation =
        Tween<double>(begin: timerWidth + Globals.defaultPadding, end: 0)
            .animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.2, 1, curve: Curves.easeIn),
      ),
    );
    lockerAnimation =
        Tween<double>(begin: lockerHeight + Globals.defaultPadding, end: 0)
            .animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.2, 1, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        lockSlider(),
        cancelSlider(),
        audioButton(),
        if (isLocked) timerLocked(),
      ],
    );
  }

  Widget lockSlider() {
    return Positioned(
      bottom: -lockerAnimation.value,
      child:!showBottomIcon?SizedBox() :Container(
        height: lockerHeight,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Globals.borderRadius),
          color: buttonColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FaIcon(
              FontAwesomeIcons.lock,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            FlowShader(
              direction: Axis.vertical,
              child: Column(
                children: [
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelSlider() {
    return Positioned(
      right: -timerAnimation.value,
      child: Container(
        height: size,
        width: timerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Globals.borderRadius),
          color: buttonColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              showLottie
                  ? LottieAnimation()
                  : Text(
                      recordDuration,
                      style: TextStyle(
                          color: Colors.white, fontFamily: AppFonts.segoeui),
                    ),
              SizedBox(width: size),
              FlowShader(
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_left),
                    Text(
                      "Slide to cancel",
                      style: TextStyle(
                          color: Colors.white, fontFamily: AppFonts.segoeui),
                    )
                  ],
                ),
                duration: const Duration(seconds: 3),
                flowColors: const [Colors.white, Colors.grey],
              ),
              SizedBox(width: size),
            ],
          ),
        ),
      ),
    );
  }

  Widget timerLocked() {
    return Positioned(
      right: 0,
      child: Container(
        height: size,
        width: timerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Globals.borderRadius),
          color: buttonColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 25),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              Vibration.vibrate(duration: 100);
              timer?.cancel();
              timer = null;
              startTime = null;
              recordDuration = "00:00";
              setState(() {
                showBottomIcon=false;
              });
              // var filePath = await Record().stop();
              // AudioState.files.add(filePath!);
              // Globals.audioListKey.currentState!
              //     .insertItem(AudioState.files.length - 1);
              widget.recordStop!.call();
              // debugPrint(filePath);
              setState(() {
                isLocked = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  recordDuration,
                  style: TextStyle(
                      color: Colors.white, fontFamily: AppFonts.segoeui),
                ),
                FlowShader(
                  child: Text(
                    "Tap lock to stop",
                    style: TextStyle(
                        color: Colors.white, fontFamily: AppFonts.segoeui),
                  ),
                  duration: const Duration(seconds: 3),
                  flowColors: const [Colors.white, Colors.grey],
                ),
                const Center(
                  child: FaIcon(
                    FontAwesomeIcons.lock,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget audioButton() {
    return GestureDetector(
      child: Transform.scale(
        scale: buttonScaleAnimation.value,
        child: Container(
          child: const Icon(
            Icons.mic,
            color: Colors.white,
          ),
          height: size,
          width: size,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: greenColor,
          ),
        ),
      ),
      onLongPressDown: (_) {
        debugPrint("onLongPressDown");
        setState(() {
          showBottomIcon=true;
        });
        widget.controller.forward();
      },
      onLongPressEnd: (details) async {
        debugPrint("onLongPressEnd");

        if (isCancelled(details.localPosition, context)) {
          Vibration.vibrate(duration: 300);

          timer?.cancel();
          timer = null;
          startTime = null;
          recordDuration = "00:00";

          setState(() {
            showLottie = true;
          });
          setState(() {
            showBottomIcon=false;
          });
          Timer(const Duration(milliseconds: 1440), () async {
            widget.controller.reverse();
            debugPrint("Cancelled recording");
            // var filePath = await record.stop();
            // debugPrint(filePath);
            // File(filePath!).delete();
            // debugPrint("Deleted $filePath");
            showLottie = false;
          });
        } else if (checkIsLocked(details.localPosition)) {
          widget.controller.reverse();
          Vibration.vibrate(duration: 300);
          debugPrint("Locked recording");
          debugPrint(details.localPosition.dy.toString());
          setState(() {
            isLocked = true;
          });
        } else {
          widget.controller.reverse();
          Vibration.vibrate(duration: 300);

          timer?.cancel();
          timer = null;
          startTime = null;
          recordDuration = "00:00";

          // var filePath = await Record().stop();
          // AudioState.files.add(filePath!);
          // Globals.audioListKey.currentState!
          //     .insertItem(AudioState.files.length - 1);
          // debugPrint(filePath);
          widget.recordStop!.call();
        }
      },
      onLongPressCancel: () {
        debugPrint("onLongPressCancel");
        widget.controller.reverse();
      },
      onLongPress: () async {
        debugPrint("onLongPress");
        Vibration.vibrate(duration: 300);
        if (await record.Record().hasPermission()) {
          // record = Record();
          // await record.start(
          //   path: Globals.documentPath +
          //       "audio_${DateTime.now().millisecondsSinceEpoch}.m4a",
          //   encoder: AudioEncoder.AAC,
          //   bitRate: 128000,
          //   samplingRate: 44100,
          // );
          widget.RecordStart!.call();
          startTime = DateTime.now();
          timer = Timer.periodic(const Duration(seconds: 1), (_) {
            if(startTime!=null){
              final minDur = DateTime.now().difference(startTime!).inMinutes;
              final secDur = DateTime.now().difference(startTime!).inSeconds % 60;
              String min = minDur < 10 ? "0$minDur" : minDur.toString();
              String sec = secDur < 10 ? "0$secDur" : secDur.toString();
              setState(() {
                recordDuration = "$min:$sec";
              });
            }
          });
        }
      },
    );
  }

  bool checkIsLocked(Offset offset) {
    return (offset.dy < -35);
  }

  bool isCancelled(Offset offset, BuildContext context) {
    return (offset.dx < -(MediaQuery.of(context).size.width * 0.2));
  }
}
