import 'package:animia/graphqlFiles/quaries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphqlFiles/graphql_config.dart';
import 'descriptionScreen.dart';
import 'hexColorConverter.dart';
import 'trendingAnime.dart';

class SearchEngine extends StatefulWidget {
  const SearchEngine({super.key});

  // final String aniName;
  // final int page;
  // final int perPage;

  // const searchAnime(
  //     {super.key,
  //     required this.aniName,
  //     required this.page,
  //     required this.perPage});

  @override
  State<SearchEngine> createState() => _SearchEngineState();
}

class _SearchEngineState extends State<SearchEngine> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearching() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(GraphQLConfig.client()),
      child: Scaffold(
        // appBar: AppBar(
        //   title: TextField(
        //     controller: _searchController,
        //     decoration: InputDecoration(
        //       hintText: 'Search Anime',
        //       suffixIcon: IconButton(
        //         icon: const Icon(Icons.search),
        //         onPressed: performSearching,
        //       ),
        //     ),
        //     onSubmitted: (value) {
        //       performSearching();
        //     },
        //   ),
        // ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // Query(
              //   options: QueryOptions(
              //     document: gql(searchQueryForPages),
              //     variables: {'search': _searchQuery},
              //   ),
              //   builder: (QueryResult result, {refetch, fetchMore}) {
              //     if (result.isLoading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //     if (result.hasException) {
              //       return Center(child: Text(result.exception.toString()));
              //     }
              //
              //     final data = result.data?['Page']['media'];
              //     if (data == null) {
              //       return const Center(child: Text('No data found'));
              //     }
              //
              //     return buildSearchResults(data);
              //   },
              // ),
              const Text(
                'Trending Anime',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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

              Query(
                options: QueryOptions(
                  document: gql(trendingAnime),
                  variables: {"page": 1, "perPage": 10},
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
}

Widget buildSearchResults(data) {
  return SizedBox(
    //height: 200,
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, index) {
        return animeCards(data, index, context);
      },
    ),
  );
}

Column animeCards(data, int index, BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DescriptionScreen(
                title: data[index]['title']['romaji'],
                description: data[index]['description'],
                image: data[index]['coverImage']['large'],
                avgScore: data[index]['averageScore'],
                color: data[index]['coverImage']['color'],
                timeUntilAiring: data[index]['nextAiringEpisode']
                    ['timeUntilAiring'],
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          // height: 270.0,
          // width: 190.0,
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
                                  fontSize: 16, fontWeight: FontWeight.w500),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var genre in data[index]['genres'].take(2))
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Chip(
                                    label: Text(genre),
                                    backgroundColor: HexColor(
                                            colorValue: data[index]
                                                    ['coverImage']['color'] ??
                                                '#FFFFFF')
                                        .parseHexColor(),
                                  ),
                                ),
                            ],
                          ),
                          if (data[index]['genres'].length > 2)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Chip(
                                    label: Text(data[index]['genres'][2]),
                                    backgroundColor: HexColor(
                                            colorValue: data[index]
                                                    ['coverImage']['color'] ??
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
  );
}
