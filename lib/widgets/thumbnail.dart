import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbnail_generator/screens/play_video_screen.dart';
import 'package:video_player/video_player.dart';

class Thumbnail extends StatefulWidget {
  const Thumbnail({super.key, this.url, this.thumbnail, required this.index});
  final String? url;
  final String? thumbnail;
  final int index;
  @override
  State<Thumbnail> createState() => _ThumbnailState();
}

class _ThumbnailState extends State<Thumbnail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url!),
      videoPlayerOptions: VideoPlayerOptions(),
    );
    _controller.initialize();
    // Navigator.of(context).addListener(navigatorListener);
  }

  void navigatorListener() {
    // Check if the route stack has changed
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    // Remove the listener when the screen is disposed
    //Navigator.of(context).removeListener(navigatorListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PlayVideoScreen(url: widget.url!, controller: _controller)));
        _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.url!),
          videoPlayerOptions: VideoPlayerOptions(),
        );
        _controller.initialize();
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width / 3,
            // decoration: BoxDecoration(color: Colors.cyan),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.thumbnail!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.cyan,
                          value: downloadProgress.progress),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
                // Image.network(
                //   widget.thumbnail!,
                //   loadingBuilder: (context, child, loadingProgress) {
                //     if (loadingProgress == null) {
                //       return child;
                //     }
                //     return SizedBox(
                //       height: 100,
                //       width: 100,
                //       child: Center(
                //         child: CircularProgressIndicator(
                //           value: loadingProgress.cumulativeBytesLoaded /
                //               loadingProgress.expectedTotalBytes!,
                //           color: Colors.cyan,
                //           strokeWidth: 2,
                //         ),
                //       ),
                //     );
                //   },
                //   fit: BoxFit.cover,
                // ),
                ),
          ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(
          //       sigmaX: 5,
          //       sigmaY:
          //           5), // Adjust the sigmaX and sigmaY values for the desired blur effect
          //   child: Container(
          //     width: MediaQuery.of(context).size.width / 3,
          //     height: 200,
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(
          //           0.1), // Adjust the opacity and color as per your preference
          //     ),
          //   ),
          // ),
          (widget.index >= 0 && widget.index <= 2)
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.pink,
                      ),
                      child: Text(
                        "Pinned",
                        style: GoogleFonts.roboto(
                            color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          Positioned(
            bottom: 10,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.play_arrow_outlined,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    Text(
                      "15.4k",
                      style: GoogleFonts.roboto(
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
