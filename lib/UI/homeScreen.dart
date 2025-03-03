

import 'package:animia/UI/slider.dart';
import 'package:animia/UI/trendingAnime.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphqlFiles/graphql_config.dart';
import '../graphqlFiles/quaries.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              const AnimeSlider(),
              const Text(
                'Trending Anime',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TrendingAnimeSection(queryName: trendingAnime),
              const Text(
                'All time popular',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TrendingAnimeSection(queryName: allTimePopular)
            ],
          ),
        ),
      ),
    );
  }
}
