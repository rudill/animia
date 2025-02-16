import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphqlFiles/graphql_config.dart';
import '../graphqlFiles/quaries.dart';

class TrendingAnimeSection extends StatelessWidget {
  const TrendingAnimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(GraphQLConfig.client()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              trendingQuery(),
            ],
          ),
        ),
      ),
    );
  }

  Query<Object?> trendingQuery() {
    return Query(
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
            );
  }
}

Widget buildTrendingResults(data) {
  return SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final anime = data[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  anime['coverImage']['large'],
                  width: 120,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
