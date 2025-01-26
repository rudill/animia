import 'package:animia/graphql_config.dart';
import 'package:animia/quaries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class animaMainScreen extends StatelessWidget {
  final int aniId;
  const animaMainScreen({super.key, required this.aniId});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(

      client: ValueNotifier(GraphQLConfig.client()),
      child: Scaffold(
        body: Query(

            options: QueryOptions(
              document: gql(query),
              variables: {'id':aniId},
            ),
            builder: (QueryResult result, {refetch, fetchMore}) {

              if (result.isLoading){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (result.hasException) {
                return Center(child: Text(result.exception.toString()));
              }

              final data = result.data?['Media'];
              if (data == null){
                return const Center(child: Text('No data found'));
              }

              return Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title']['romaji'] ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Image.network(data['coverImage']['large']),

                  ],
                ),

              );

            }

        ),
      ),

    );
  }
}
