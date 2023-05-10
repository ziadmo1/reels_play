import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reels_play/upload.dart';

class UploadVideo extends StatefulWidget {

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  File? video;
  File? audio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text('Upload Video',style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
                ),),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    Container(
                      width: 240,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(BorderSide(color: Colors.white))
                      ),
                      child: video == null ? Text('No Video Uploaded',style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                      ),) : Row(
                        children: [
                            Icon(Icons.video_collection_outlined,color: Colors.red,),
                          SizedBox(width: 8,),
                            Expanded(
                              child: Text(video?.path??'',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white
                              ),),
                            )
                        ],
                      ),
                    ),
                    SizedBox(width: 5,),
                    IconButton(onPressed: ()async{
                     await uploadVideo();
                    }, icon: Icon(Icons.add,color: Colors.red,size: 30,))
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Text('Upload Audio',style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
                ),),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    Container(
                      width: 240,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(BorderSide(color: Colors.white))
                      ),
                      child: audio == null ? Text('No Audio Uploaded',style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                      ),) : Row(
                        children: [
                            Icon(Icons.audiotrack_outlined,color: Colors.red,),
                          SizedBox(width: 8,),
                            Expanded(
                              child: Text(audio?.path??'',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white
                              ),),
                            )
                        ],
                      ),
                    ),
                    SizedBox(width: 5,),
                    IconButton(onPressed: ()async{
                        await uploadAudio();
                    }, icon: Icon(Icons.add,color: Colors.red,size: 30,))
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }

  uploadVideo()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video
    );
    if(result == null)return;
    if (result != null) {
      video = File(result.files.single.path??'');
      await uploadAudioOrVideo(video?.path??'','mp4');
        setState(() {

        });
    }
  }

  uploadAudio()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio
    );
    if(result == null)return;
    if (result != null) {
      audio = File(result.files.single.path??'');
     await uploadAudioOrVideo(audio?.path??'','mp3');
      setState(() {

        });
    }
  }
}
