import 'package:animia/graphql_config.dart';
import 'package:animia/quaries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class animaMainScreen extends StatelessWidget {
  //final int aniId;
  final String aniName;
  const animaMainScreen({super.key, required this.aniName});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(GraphQLConfig.client()),
      child: Scaffold(
        body: Query(
            options: QueryOptions(
              document: gql(searchQuery),
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

              final data = result.data?['Media'];
              if (data == null) {
                return const Center(child: Text('No data found'));
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(data['coverImage']['extraLarge']?? data['coverImage']['large'],


                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(

                        decoration: BoxDecoration(
                          color: _parseHexColor(data['coverImage']['color']),
                        ),

                        child: Center(
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              data['title']['romaji'] ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                        ),


                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

Color _parseHexColor(String? hexColor) {
  if (hexColor == null || hexColor.isEmpty) {
    return Colors.grey; // Fallback color
  }

  try {
    // Remove the "#" if it exists and parse the color
    return Color(int.parse(hexColor.replaceFirst('#', ''), radix: 16) + 0xFF000000);
  } catch (e) {
    // If parsing fails, return a default color
    return Colors.grey;
  }
}
