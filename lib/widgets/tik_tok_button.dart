import 'package:flutter/material.dart';

class TikTokButton extends StatelessWidget {
  const TikTokButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 45.0,
        height: 27.0,
        child: Stack(children: [
          Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 45, 108),
                  borderRadius: BorderRadius.circular(7.0))),
          Container(
              margin: const EdgeInsets.only(right: 10.0),
              width: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 32, 211, 234),
                  borderRadius: BorderRadius.circular(7.0))),
          Center(
              child: Container(
            height: double.infinity,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(7.0)),
            child: const Icon(
              Icons.add,
              size: 20.0,
              color: Colors.white,
            ),
          )),
        ]));
  }
}
