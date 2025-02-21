import 'package:flutter/material.dart';

import 'hexColorConverter.dart';

class DescriptionScreen extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int avgScore;
  final String color;

  const DescriptionScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      required this.avgScore,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
                height: 430,
                width: 360,
                fit: BoxFit.cover,
              ),
            ),

            Row(
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 130,
                            height: 130,
                            child: Transform.scale(
                              scale: 1,
                              child: ClipOval(
                                child: CircularProgressIndicator(
                                  value: avgScore / 100,
                                  strokeWidth: 18,
                                  color: HexColor(colorValue: color)
                                          .parseHexColor() ??
                                      Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            child: Chip(
                          label: Text(
                            avgScore.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          backgroundColor:
                              HexColor(colorValue: color).parseHexColor() ??
                                  Colors.white,
                        ))
                      ],
                    )
                  ],
                ),
                // Column(
                //   children: [
                //     Stack(
                //       alignment: Alignment.center,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: SizedBox(
                //             width: 100,
                //             height: 100,
                //             child: Transform.scale(
                //               scale: 1,
                //               child: const CircularProgressIndicator(
                //                 value: 0.8,
                //                 strokeWidth: 10,
                //               ),
                //             ),
                //           ),
                //         ),
                //         const Positioned(
                //           child: Text(
                //             'e',
                //           ),
                //         )
                //       ],
                //     )
                //   ],
                // ),
              ],
            )

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SingleChildScrollView(
            //     child: Text(
            //       description,
            //       style: const TextStyle(
            //         fontSize: 20,
            //         color: Colors.white,
            //       ),
            //   //    overflow: TextOverflow.ellipsis,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
