import 'package:flutter/material.dart';

import 'circularprogressPainter.dart';
import 'colorSetter.dart';
import 'hexColorConverter.dart';

class DescriptionScreen extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int? avgScore;
  final String? color;
  final int? timeUntilAiring;
  final int? episode;

  const DescriptionScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      this.avgScore,
      this.color,
      this.timeUntilAiring,
      this.episode});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation =
        Tween<double>(begin: 0, end: (widget.avgScore ?? 0) / 100).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  String convertTime() {
    if (widget.timeUntilAiring == null) {
      return 'N/A';
    } else {
      double? timeHours = ((widget.timeUntilAiring! / 60) / 60) / 24;
      int timeHoursRounded = timeHours.round();

      return '${timeHoursRounded.toString()} Days';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.image,
                  height: 430,
                  width: 360,
                  fit: BoxFit.cover,
                ),
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
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return CustomPaint(
                                  painter: CircularProgressPainter(
                                      progress: _animation.value,
                                      color:
                                          getScoreColor(widget.avgScore ?? 0)),
                                );
                              },
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Text(
                              '${(_animation.value * 100).toInt()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Text(
                      'Average score',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: HexColor(colorValue: widget.color ?? '#FFFFFF')
                            .parseHexColor(),
                        width: 2, // Set the width of the border
                      ),
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: HexColor(colorValue: widget.color ?? '#FFFFFF')
                      //         .parseHexColor(),
                      //    // blurRadius: 2,
                      //     spreadRadius: 2,
                      //   ),
                      // ],
                    ),
                    height: 50,
                    width: 150,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Episode ${widget.episode.toString()} airing in',
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              convertTime(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
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
