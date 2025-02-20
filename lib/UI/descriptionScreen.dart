import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int avgScore;

  const DescriptionScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      required this.avgScore});

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
                            width: 100,
                            height: 100,
                            child: Transform.scale(
                              scale: 1,
                              child:  CircularProgressIndicator(
                                value: avgScore/100,
                                strokeWidth: 10,
                              ),
                            ),
                          ),
                        ),
                         Positioned(
                          child: Text(
                            avgScore.toString()
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Transform.scale(
                              scale: 1,
                              child: const CircularProgressIndicator(
                                value: 0.8,
                                strokeWidth: 10,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          child: Text(
                            'e',
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
