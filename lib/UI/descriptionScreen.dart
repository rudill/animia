import 'package:flutter/material.dart';

import 'circularprogressPainter.dart';
import 'hexColorConverter.dart';

class DescriptionScreen extends StatefulWidget {
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
    _animation = Tween<double>(begin: 0, end: widget.avgScore / 100).animate(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                widget.image,
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
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 130,
                            height: 130,
                            child: AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: CircularProgressPainter(
                                      progress: _animation.value,
                                      color: HexColor(colorValue: widget.color)
                                          .parseHexColor(),
                                    ),
                                  );
                                }),
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
