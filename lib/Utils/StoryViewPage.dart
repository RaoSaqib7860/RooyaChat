import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Models/UserStoriesModel.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewPage extends StatefulWidget {
  final UserStoryModel? userStories;

  const StoryViewPage({Key? key, this.userStories}) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: StoryView(
              controller: controller,
              storyItems: widget.userStories!.stories!.map((e) {
                return StoryItem.inlineImage(
                  url: "${e.thumbnail}",
                  controller: controller,
                  caption: Text(
                    "${e.description}",
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                );
              }).toList(),
              onStoryShow: (s) {
                print("Showing a story");
              },
              onComplete: () {
                print("Completed a cycle");
              },
              progressPosition: ProgressPosition.top,
              repeat: false,
              inline: true,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
