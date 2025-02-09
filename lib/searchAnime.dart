import 'package:animia/quaries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_config.dart';

class searchAnime extends StatelessWidget {
  final String aniName;
  final int page;
  final int perPage;

  const searchAnime(
      {super.key,
      required this.aniName,
      required this.page,
      required this.perPage});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(GraphQLConfig.client()),
      child: Scaffold(
        body: Query(
            options: QueryOptions(
              document: gql(searchQueryForPages),
              variables: {'search': aniName},
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

              return buildSearchResults(data, perPage);
            }),
      ),
    );
  }
}

Widget buildSearchResults(data, perPage) {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (BuildContext context, index) {
      return animeCards(data, index);
    },
  );
}

Column animeCards(data, int index) {
  return Column(
    children: [
      Container(
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
                SizedBox(
                  child: Image.network(
                    data[index]['coverImage']['large'],
                    width: 150,
                    height: 200,
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
                    Row(
                      children: [
                        Text(
                          data[index]['status'] ?? 'TBA',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var genre in data[index]['genres'])
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                genre ?? 'N/A',
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          data[index]['averageScore'].toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
