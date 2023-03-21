import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController controller;
  List videos = [
    'https://obaadz.github.io/videos/maly.mp4',
    'https://obaadz.github.io/videos/fouad.mp4',
    'https://obaadz.github.io/videos/eiqtsad.mp4',
    'https://obaadz.github.io/videos/course.mp4',
    'https://obaadz.github.io/videos/course.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];
  bool isPlay = true;
  bool isInitialize = false;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
       videos[0]);
    controller.initialize().whenComplete(()async{
     isInitialize = true;
     await controller.play();
     setState(() {
     });
    });
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        reverse: false,
        onPageChanged: (index) async {
          isPlay = true;
          isInitialize = false;
         await controller.pause();
          controller = VideoPlayerController.network(videos[index])..initialize().whenComplete(()async {
            isInitialize = true;
            await controller.play();
            setState(() {
            });
          });
         await controller.setLooping(true);
          setState(() {});
        },
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: ()async{
              isPlay = !isPlay;
              isPlay == true ?await controller.play():await controller.pause();
              setState(() {
              });
            },
            child: Container(
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    isInitialize == true ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller)):CircularProgressIndicator(color: Colors.red,),
                   isPlay == false ? Icon(Icons.play_arrow,size: 150,color: Colors.grey.withOpacity(0.7),) : Container()
                  ],
                )),
          );
        },
        itemCount: videos.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
