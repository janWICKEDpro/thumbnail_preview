import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thumbnail_generator/services/models/video.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class ThumbnailService {
  late VideoPlayerController controller;
  final firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<Uint8List?> generateThumbnailImage(String url) async {
    try {
      controller = VideoPlayerController.networkUrl(
        Uri.parse(url),
        videoPlayerOptions: VideoPlayerOptions(),
      );
      controller.initialize();
      final thumbnail = await VideoThumbnail.thumbnailData(video: url);
      return thumbnail;
    } catch (e) {
      rethrow;
    }
  }

  // Map<String, Object> requestBody(String url) {
  //   return {
  //     'tasks': {
  //       'import-1': {
  //         "operation": "import/url",
  //         "url": url,
  //       },
  //       'task-1': {
  //         'operation': 'thumbnail',
  //         "input": ["import-1"],
  //         "input_format": "mp4",
  //         "output_format": "png",
  //         "fit": "crop"
  //       },
  //       'export-1': {
  //         'operation': 'export/url',
  //         'input': ['import-1', 'task-1'],
  //         'inline': false,
  //         'archive_multiple_files': false
  //       }
  //     },
  //     'tag': 'jobbuilder'
  //   };
  // }

  // Future convertFile(String url) async {
  //   final body = requestBody(url);
  //   log(body.toString());
  //   try {
  //     controller = VideoPlayerController.networkUrl(
  //       Uri.tryParse(url)!,
  //       videoPlayerOptions: VideoPlayerOptions(),
  //     );
  //     controller.initialize();
  //     final response =
  //         await http.post(Uri.parse(api), body: jsonEncode(body), headers: {
  //       'Authorization':
  //           "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODI0YjA4NjNhNmNlMTI2NmNhNzJkZTdmOGVlMzIwNmI0OGIwMTc1ZDE5ZWQxZmQ3NDAwYmRhYmYyMWY0NzM3ZmI1ZDIyNjI1YWRiZWEyYjYiLCJpYXQiOjE3MDY1NTU2MzcuNjg5MjU2LCJuYmYiOjE3MDY1NTU2MzcuNjg5MjU3LCJleHAiOjQ4NjIyMjkyMzcuNjgwOTIxLCJzdWIiOiI2NzAwNzc5NSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.T6VI9DAJPsnCeWKa74R9pWFIeTGtfW5QNOuBfoZEm8qchmbBwZgOLBh38jOk0xHP5fD8CRvY_OxSUZLgQ2LBv7kKG7Ie8OpN7mwLsSqvuyw4MuqJgSbqPYPgFn8fQgwLjxqo_6KMtkZF2yrCxTj6E-41S1D-tEffgHOR6LKl0fBBi4mmiVpF5dIh-Z9R0KJrEGI8vr7xl2r2hFh6wl_5FHLeLRgNepg54KGPzRgwSW_AZJz5DRnC3nUyFyS3pvemTTIA97a6-POtiCpV7kmHkXgdlDlVfZPUOSdv_FMyWO-ynR6ByeobxYIs1j6lavpEl2Z1AmA7a64ILW_CnpWnfyfrrTI0tVNZAwGgYKmVurecyZQW4n9ZumEgwP5RhXCYzcNNIhFvmAo2u9rHVQlRUNpG_AFX4tfH7rpmJWmDnIcfApipv9ox6iS8f2qvJ4jzWegg5IOHTBlAZwasicfFJA1MBe3dFet3u1XfX4F3y83x_se2_UIGMuRp5W_Ip_b4TXflXUrq02YaXuzk0ETnrgyyTwKkNbtU0ma8cTK8Qb59c_O8fBCA0Vc0ZjbEYSYJjDpNQuuEXPCOhpK65Su-R0efg0TYIZRV-U0Cjsf9JeKRrgJCYXVbLseKeTP6T9VHjP9r6gP6oGp3gXKOM2Px0fvQQT1Qqn0ij9kb76ee8Uc",
  //       'Content-type': 'application/json'
  //     });

  //     return (jsonDecode(response.body)['data']['tasks'][0]['result']['files']
  //         [1]['url']);
  //   } catch (e) {
  //     log('$e');
  //   }
  // }

  Future pickVideo() async {
    return await ImagePicker().pickVideo(source: ImageSource.gallery);
  }

  Future<Uint8List?>? createThumbnail(String path) async {
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: path,
        imageFormat: ImageFormat.PNG,
      );
      return uint8list;
    } catch (e) {
      throw Exception("Error occured");
    }
  }

  Future<void> uploadFilesToFirebase(
      XFile _videoFile, Uint8List _thumbnailFile) async {
    final String videoPath = 'vid${DateTime.now().millisecondsSinceEpoch}.mp4';
    final String thumbnailPath =
        'thumb${DateTime.now().millisecondsSinceEpoch}.png';
    final videoBytes = await _videoFile.readAsBytes();
    final futures = [
      storage.ref().child(videoPath).putData(videoBytes),
      storage.ref().child(thumbnailPath).putData(_thumbnailFile)
    ];
    try {
      await Future.wait(futures);
      print("stored images");
      final videoUrl = await storage.ref().child(videoPath).getDownloadURL();
      final thumbnailUrl =
          await storage.ref().child(thumbnailPath).getDownloadURL();
      print("Gotten download url");

      final docRef = firestore.collection('POSTS').doc();
      await docRef.set({
        'url': videoUrl,
        'thumbnail': thumbnailUrl,
      });
      print(docRef);
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<Video>> getPostsFromFirebase() async {
    QuerySnapshot querySnapshot = await firestore.collection('POSTS').get();

    return querySnapshot.docs
        .map((doc) => Video.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
