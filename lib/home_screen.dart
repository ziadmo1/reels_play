import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reels_play/upload.dart';
import 'package:sn_progress_dialog/options/cancel.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:video_player/video_player.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List media = ['http://alkotaxtlatxtlatat.ddns.net:5000/uploads/course.mp4'];
  List types = ['video/mp4'];
  bool isPlay = true;
  bool isInitialize = false;
 late VideoPlayerController controller;
@override
  void initState() {
  controller = VideoPlayerController.network(
      media[0]);
  controller.initialize().whenComplete(()async{
    isInitialize = true;
    await controller.play();
    var mediaRes = await  mediaData();
    var paths =  mediaRes.medias?.reversed.map((e){
      return e.paths?.high;
    }).toList();
    var type =  mediaRes.medias?.reversed.map((e){
      return e.type;
    }).toList();
    if(media.length == 1){
      for(int i = 0;i<paths!.length;i++) {
        media.add('http://alkotaxtlatxtlatat.ddns.net:5000/${paths[i]}');
        types.add(type?[i]);

      }
    }
    setState(() {
    });

  });
  controller.setLooping(true);
  super.initState();
  }
  @override
  void dispose() {
controller.dispose();
super.dispose();
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
              controller = VideoPlayerController.network(media[index])
                ..initialize().whenComplete(() async {
                  isInitialize = true;
                  await controller.play();
                  setState(() {});
                });
              await controller.setLooping(true);
              setState(() {});
            },
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  isPlay = !isPlay;
                  isPlay == true ? await controller.play() : await controller.pause();
                  setState(() {});
                },
                child: Container(
                    color: Colors.black,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        isInitialize == true
                            ?AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller))
                            : CircularProgressIndicator(color: Colors.red,),
                        types[index] == 'video/mp4'?Container(): Image.asset('assets/logo.png'),
                        isPlay == false ? Icon(
                          Icons.play_arrow, size: 150, color: Colors.grey
                            .withOpacity(0.7),) : Container()
                      ],
                    )),
              );
            },
            itemCount: media.length,
            scrollDirection: Axis.vertical,
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          progressDownload();
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.download,color: Colors.white,),
      ),
    );
  }
  progressDownload() async {
    ProgressDialog pd = ProgressDialog(context: context);
    var directory = await getApplicationSupportDirectory();
    print(directory.path);
    pd.show(
        max: 100,
        msg: 'Preparing Download...',
        progressType: ProgressType.normal,
        backgroundColor: Color(0xff212121),
        progressValueColor: Color(0xff212121),
        progressBgColor: Colors.red,
        msgColor: Colors.white,
        valueColor: Colors.white,
        onStatusChanged: (dialogStates){

        },
        cancel: Cancel(
            cancelClicked: (){
          pd.close(delay: 300);
        })
    );
    await Future.delayed(Duration(milliseconds: 3000));
    var dio = Dio();
    await dio.download(
      'https://obaadz.github.io/videos/maly.mp4',
        '${directory.path}maly.mp4',
      onReceiveProgress: (rec, total) {
        int progress = (((rec / total) * 100).toInt());
        pd.update(value: progress, msg: 'Video Downloading...',);
      },
    );
   await File('${directory.path}maly.mp4').copy('/storage/emulated/0/ffffff/maly.mp4');
    // File('${directory?.path}maly.mp4').renameSync('/storage/emulated/0/ffffff/maly.mp4');
  }
}
