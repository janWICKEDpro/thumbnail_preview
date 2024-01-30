import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbnail_generator/services/models/video.dart';
import 'package:thumbnail_generator/services/thumbnail_service.dart';
import 'package:thumbnail_generator/widgets/thumbnail.dart';
import 'dart:math' as math;

import 'package:thumbnail_generator/utils.dart';
import 'package:thumbnail_generator/widgets/tik_tok_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loadingPosts = false;
  bool isUploading = false;
  String message = "";
  final service = ThumbnailService();
  List<Video> posts = [];

  @override
  void initState() {
    super.initState();
    loadContent();
  }

  void loadContent() async {
    setState(() {
      loadingPosts = true;
    });
    final post = await service.getPostsFromFirebase();
    setState(() {
      loadingPosts = false;
      posts = post;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                color: Colors.cyan,
                height: isUploading ? 30 : 0,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Gap(20),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                          child: isUploading
                              ? const CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white)
                              : const SizedBox()),
                    ),
                  ],
                )),
              )),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          ],
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Metricool ES",
                style: GoogleFonts.roboto(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Gap(5),
              PopupMenuButton(
                  child: Row(
                    children: [
                      Gap(2),
                      Transform.rotate(
                        angle: math.pi / 2,
                        child: Text(
                          "8",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ),
                      Gap(2),
                      Stack(
                        children: [
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.pink,
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: -math.pi / 2,
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  itemBuilder: (context) {
                    return [const PopupMenuItem(child: Text("Tik Tok"))];
                  })
            ],
          ),
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.person_add_outlined)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FloatingActionButton(
                      onPressed: () {},
                      elevation: 0,
                      mini: true,
                      shape: const CircleBorder(eccentricity: 1.0),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(10),
            Text(
              "@metricool_com",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "146",
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Following",
                        style: GoogleFonts.roboto(
                            color: Colors.grey.withOpacity(0.9),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "40,k",
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Follower",
                        style: GoogleFonts.roboto(
                            color: Colors.grey.withOpacity(0.9),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "182,6k",
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Likes",
                        style: GoogleFonts.roboto(
                            color: Colors.grey.withOpacity(0.9),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.grey.withOpacity(0.8))),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(0)),
                  onPressed: () {},
                  child: Text(
                    "Edit Profile",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const Gap(5),
                OutlinedButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.grey.withOpacity(0.8))),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0)),
                    onPressed: () {},
                    child: const Icon(
                      Icons.camera_enhance_outlined,
                      color: Colors.black,
                    )),
              ],
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "ANALYSIS 📉 PLANIFICATION🗓 INFORMES📰 ADS💲 \n 👇Comienza GRATIS ahora.",
                style: GoogleFonts.roboto(),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(angle: -math.pi / 4, child: Icon(Icons.link)),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "https://mtr.bio/metricool-tiktok",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.question_answer_outlined,
                  color: Colors.pink,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Q&A",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
              ],
            ),
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(icon: Icon(Icons.payment)),
                Tab(icon: Icon(Icons.lock_outline)),
                Tab(icon: Icon(Icons.bookmark_add_outlined)),
                Tab(icon: Icon(Icons.favorite_border)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.9)),
                        borderRadius: BorderRadius.circular(4)),
                    child: const Icon(Icons.add),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: texts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.9)),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                children: [
                                  const Icon(Icons.library_books_rounded),
                                  Text(
                                    texts[index],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.camera_enhance),
                    Gap(2),
                    Text(
                      "View expired Stories in \"Your private Videos\" ",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.cancel_outlined))
              ],
            ),
            Expanded(
              child: Container(
                child: loadingPosts
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.cyan,
                        ),
                      )
                    : GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        children: [
                          ...posts.mapIndexed((index, e) => Thumbnail(
                                url: e.url,
                                thumbnail: e.thumbnail,
                                index: index,
                              ))
                        ],
                      ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: 4,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.withOpacity(0.8),
            showUnselectedLabels: true,
            unselectedLabelStyle:
                GoogleFonts.roboto(fontWeight: FontWeight.bold),
            selectedLabelStyle: GoogleFonts.roboto(
                color: Colors.black, fontWeight: FontWeight.bold),
            onTap: (value) async {
              if (value == 2) {
                setState(() {
                  isUploading = true;
                });
                final _file = await service.pickVideo();

                setState(() {
                  message = "Creating Thumbnail";
                });
                final thumbnail = await service.createThumbnail(_file.path);
                setState(() {
                  message = "uploading video";
                });
                await service.uploadFilesToFirebase(_file, thumbnail!);
                print("completed the upload \n \n");
                setState(() {
                  isUploading = false;
                  message = "";
                });
                loadContent();
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined), label: "Friends"),
              BottomNavigationBarItem(icon: TikTokButton(), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "inbox"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "profile"),
            ]),
      ),
    );
  }
}
