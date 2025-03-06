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
  final int? popularity;

  const DescriptionScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      this.avgScore,
      this.color,
      this.timeUntilAiring,
      this.episode,
      this.popularity});

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
    }
    double? timeDays = ((widget.timeUntilAiring! / 60) / 60) / 24;
    double? timeHours = (widget.timeUntilAiring! / 60) / 60;
    int timeHoursRounded = timeHours.round();
    int timeDaysRounded = timeDays.round();

    if (timeDaysRounded == 0) {
      return '${timeHoursRounded.toString()} Hours';
    }

    return '${timeDaysRounded.toString()} Days';
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
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: CircularProgressPainter(
                                        progress: _animation.value,
                                        color: getScoreColor(
                                            widget.avgScore ?? 0)),
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
                                  fontSize: 16,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      // const Text(
                      //   'Average score',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 12,
                      //   ),
                      // )
                    ],
                  ),
                ),
                //verticalDivider(),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Ep ${widget.episode.toString()} in',
                                maxLines: 2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                convertTime(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        // const Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Text(
                        //         'Airing',
                        //         style: TextStyle(fontSize: 12),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                //verticalDivider(),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.popularity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text(
                            //   'Popularity',
                            //   style: TextStyle(fontSize: 12),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Average score',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Airing',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Popularity',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
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

  SizedBox verticalDivider() {
    return SizedBox(
      height: 60,
      child: VerticalDivider(
        color: HexColor(colorValue: widget.color ?? '#FFFFFF').parseHexColor(),
        width: 20,
        thickness: 2,
        indent: 5,
        endIndent: 5,
      ),
    );
  }
}
