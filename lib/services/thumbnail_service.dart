import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';

class ThumbnailService {
  late VideoPlayerController controller;
  Future<Uint8List?> generateThumbnailImage(String url) async {
    try {
      // controller = VideoPlayerController.networkUrl(
      //   Uri.tryParse(url)!,
      //   videoPlayerOptions: VideoPlayerOptions(),
      // );
      // controller.initialize();
      final thumbnail = await VideoThumbnail.thumbnailData(
          video: url,
          imageFormat: ImageFormat.JPEG,
          quality: 100,
          timeMs: 4000);
      return thumbnail;
    } catch (e) {
      rethrow;
    }
  }
}
