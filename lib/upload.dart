import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reels_play/models/videoModel.dart';

uploadAudioOrVideo(String path,String type)async {
  var uri = Uri.http('alkotaxtlatxtlatat.ddns.net:5000', '/v1/videos/upload');
  var request = http.MultipartRequest('POST', uri)..fields['type'] = type
     ..files.add(await http.MultipartFile.fromPath(
      'media',path
    ));
  await request.send();
}

  Future<MediaResponse>  mediaData()async{
  var uri = Uri.http('alkotaxtlatxtlatat.ddns.net:5000', '/v1/videos');
  var response =await http.get(uri);
  var body = response.body;
  var json = jsonDecode(body);
  return MediaResponse.fromJson(json);
}