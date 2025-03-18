import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphqlFiles/graphql_config.dart';
import '../graphqlFiles/nodes.dart';
import '../graphqlFiles/quaries.dart';
import 'descriptionScreen.dart';
import 'hexColorConverter.dart';

class TrendingAnimeSection extends StatelessWidget {
  final String queryName;

  const TrendingAnimeSection({super.key, required this.queryName});

  @override
  Widget build(BuildContext context) {
    return trendingQuery(queryName);
  }

  Widget trendingQuery(String query) {
    return Query(
      options: QueryOptions(
        document: gql(query),
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
    );
  }
}

Widget buildTrendingResults(data) {
  return SizedBox(
    height: 230.0,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescriptionScreen(
                    title: data[index]['title']['romaji'],
                    description: data[index]['description'],
                    image: data[index]['coverImage']['extraLarge'],
                    avgScore: data[index]['averageScore'],
                    color: data[index]['coverImage']['color'],
                    timeUntilAiring: data[index]['nextAiringEpisode']
                        ?['timeUntilAiring'],
                    episode: data[index]['nextAiringEpisode']?['episode'],
                    popularity: data[index]['popularity'],
                    genre: List<String>.from(data[index]['genres']),
                    characters: (data[index]['characters']['nodes'] as List)
                        .map((char) => Character.fromJson(char))
                        .toList(),
                    bannerImage: data[index]['bannerImage'],
                    format: data[index]['format'],
                    episodes: data[index]['episodes'],
                    status: data[index]['status'],
                  ),
                ),
              );
            },
            child: Container(
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      data[index]['coverImage']['large'],
                      width: 120,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    data[index]['title']['english'],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}


