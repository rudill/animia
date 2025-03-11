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
  final List<String>? genre;
  final String? bannerImage;

  const DescriptionScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      this.avgScore,
      this.color,
      this.timeUntilAiring,
      this.episode,
      this.popularity,
      this.genre,
      this.bannerImage});

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0), // Set the height of the AppBar
        child: AppBar(
          flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  widget.bannerImage ?? '',
                  fit: BoxFit.cover
                ),
              ),
              Positioned(
                child: Container(

                  //width: 380,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent],
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.image,
                            height: 230,
                            width: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
                              width: 50,
                              height: 50,
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
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                          child: Text(
                            widget.description,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                            //    overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 4.0,
                      children: [
                        if (widget.genre != null)
                          for (var gen in widget.genre!)
                            Chip(
                              elevation: 10.0,
                              shadowColor: HexColor(
                                      colorValue: widget.color ?? '#FFFFFF')
                                  .parseHexColor(),

                              backgroundColor: HexColor(
                                      colorValue: widget.color ?? '#FFFFFF')
                                  .parseHexColor(),

                              label: Text(gen),
                              // backgroundColor:
                              //     HexColor(colorValue: widget.color ?? '#FFFFFF')
                              //         .parseHexColor(),
                            )
                      ],
                    ),
                  ),
                ),
              ],
            )

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SingleChildScrollView(
            //     child:
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
