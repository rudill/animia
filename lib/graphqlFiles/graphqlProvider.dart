import 'package:animia/graphqlFiles/quaries.dart';
import 'package:animia/UI/singlePageResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_config.dart';

GraphQLProvider buildGraphQLProvider() {
  var aniName;
  return GraphQLProvider(
    client: ValueNotifier(GraphQLConfig.client()),
    child: Scaffold(
      body: Query(
        options: QueryOptions(
          document: gql(singleSearchQuery),
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

          return singlePageSearchResult(data);
        },
      ),
    ),
  );
}
