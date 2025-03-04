import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphqlFiles/graphql_config.dart';
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
    height: 300.0,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  GestureDetector(
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
                            timeUntilAiring: data[index]['nextAiringEpisode']?
                                ['timeUntilAiring'],
                            episode: data[index]['nextAiringEpisode']?
                            ['episode'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      //height: 270.0,
                      width: 350.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
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
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data[index]['title']['romaji'],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       data[index]['status'] ?? 'TBA',
                                  //       style: const TextStyle(
                                  //           fontSize: 16, fontWeight: FontWeight.w500),
                                  //       overflow: TextOverflow.ellipsis,
                                  //       maxLines: 3,
                                  //     ),
                                  //   ],
                                  // ),
                                  Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (var genre
                                              in data[index]['genres'].take(2))
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Chip(
                                                label: Text(genre),
                                                backgroundColor: HexColor(
                                                        colorValue: data[index][
                                                                    'coverImage']
                                                                ['color'] ??
                                                            '#FFFFFF')
                                                    .parseHexColor(),
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (data[index]['genres'].length > 2)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Chip(
                                                label: Text(
                                                    data[index]['genres'][2]),
                                                backgroundColor: HexColor(
                                                        colorValue: data[index][
                                                                    'coverImage']
                                                                ['color'] ??
                                                            '#FFFFFF')
                                                    .parseHexColor(),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       data[index]['averageScore'].toString(),
                                  //       style: const TextStyle(
                                  //           fontSize: 16, fontWeight: FontWeight.w500),
                                  //       overflow: TextOverflow.ellipsis,
                                  //       maxLines: 3,
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Text(
              //   anime['title']['romaji'],
              //   style: const TextStyle(
              //     fontSize: 12,
              //     color: Colors.white,
              //   ),
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 2,
              // ),
            ],
          ),
        );
      },
    ),
  );
}
