import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreen extends StatefulWidget {
  const PlayVideoScreen(
      {super.key, required this.url, required this.controller});
  final String url;
  final VideoPlayerController controller;
  @override
  PlayVideoScreenState createState() => PlayVideoScreenState();
}

class PlayVideoScreenState extends State<PlayVideoScreen> {
  late VideoPlayerController _controller;
  bool playing = true;
  @override
  void initState() {
    super.initState();

    _controller = widget.controller;

    // _controller.addListener(() {
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Play Screen",
          style: GoogleFonts.roboto(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          if (playing) {
            _controller.pause();
            setState(() {
              playing = false;
            });
          } else {
            _controller.play();
            setState(() {
              playing = true;
            });
          }
        },
        child: playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 2 / 4,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
