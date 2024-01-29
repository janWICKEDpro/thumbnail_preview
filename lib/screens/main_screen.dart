import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbnail_generator/screens/play_video_screen.dart';
import 'package:thumbnail_generator/services/thumbnail_service.dart';
import 'package:thumbnail_generator/utils.dart';
import 'package:thumbnail_generator/widgets/text_field_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? url = "";
  bool loading = false;
  bool showError = false;
  Uint8List? imageBytes;
  final service = ThumbnailService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //thumbnail-box
                (imageBytes == null && showError)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/images/error.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : (imageBytes == null)
                        ? Container(
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlayVideoScreen(
                                          url: url!,
                                          controller: service.controller,
                                        ))),
                            child: SizedBox(
                              height: constraints.maxHeight * 0.2,
                              width: constraints.maxWidth,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.memory(
                                  imageBytes!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                const Gap(20),
                CustomTextField(
                    label: 'Video url e.g https://example.com/hello.mp4',
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "Please enter url";
                      }
                      if (!regExp.hasMatch(input)) {
                        return "please enter a valid video url";
                      }
                      return null;
                    },
                    onChanged: (input) {
                      setState(() {
                        url = input;
                      });
                    }),
                const Gap(20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.cyan)),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        try {
                          final thumbnailBytes =
                              await service.generateThumbnailImage(url!);
                          setState(() {
                            imageBytes = thumbnailBytes;
                            showError = false;
                            loading = false;
                          });
                        } catch (e) {
                          log('$e');
                          setState(() {
                            showError = true;
                            loading = false;
                          });
                        }
                      }
                    },
                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : Text(
                            "Generate",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                ),
                const Gap(10),
                showError
                    ? Text(
                        "An Error Occured",
                        style: GoogleFonts.roboto(),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
