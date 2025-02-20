// THIS IS HOME

import 'dart:async';

import 'package:animia/UI/trendingAnime.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphqlFiles/graphql_config.dart';
import '../graphqlFiles/quaries.dart';

class TrendingSlider extends StatefulWidget {
  const TrendingSlider({super.key});

  @override
  State<TrendingSlider> createState() => _TrendingSliderState();
}

class _TrendingSliderState extends State<TrendingSlider>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        if (_currentPage < 9) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        }

        _animationController.forward(from: 0.0);
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(GraphQLConfig.client()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Query(
                options: QueryOptions(
                  document: gql(trendingAnime),
                  variables: const {"page": 1, "perPage": 10},
                ),
                builder: (QueryResult result, {refetch, fetchMore}) {
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (result.hasException) {
                    return Center(child: Text(result.exception.toString()));
                  }

                  final data = result.data?['Page']['media'];
                  if (data == null) {
                    return const Center(child: Text('No data found'));
                  }

                  return buildSizedBox(data);
                },
              ),
              Query(
                options: QueryOptions(
                  document: gql(trendingAnime),
                  variables: const {"page": 1, "perPage": 10},
                ),
                builder: (QueryResult result, {refetch, fetchMore}) {
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (result.hasException) {
                    return Center(child: Text(result.exception.toString()));
                  }

                  final data = result.data?['Page']['media'];
                  if (data == null) {
                    return const Center(child: Text('No data found'));
                  }

                  return buildTrendingResults(data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox(data) {
    return SizedBox(
      height: 500.0,
      child: PageView.builder(
        controller: _pageController,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Tween<Offset>(
                  begin: const Offset(0, 0),
                  end: const Offset(0, 0),
                ).animate(_animationController).value,
                child: child,
              );
            },
            child: sliderItem(data, index),
          );
        },
      ),
    );
  }

  // ListView buildSlides(data) {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: data.length,
  //     itemBuilder: (BuildContext context, index) {
  //       return sliderItem(data, index);
  //     },
  //   );
  // }
}

Widget sliderItem(data, int index) {
  return Container(
    height: 450,
    width: 380,
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            Image.network(
              data[index]['coverImage']['extraLarge'],
              height: 450,
              width: 380,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 100,
                width: 380,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Center(
                child: Text(
                  data[index]['title']['english'] ??
                      data[index]['title']['romaji'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        )
        // Image.network(
        //   data[index]['coverImage']['extraLarge'],
        //   height: 450,
        //   width: 380,
        //   fit: BoxFit.cover,
        // ),
        // Text(
        //   data[index]['title']['romaji'],
        //   style: const TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white,
        //   ),
        //   overflow: TextOverflow.ellipsis,
        //   maxLines: 2,
        // ),
      ],
    ),
  );
}
