import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static final HttpLink httpLink = HttpLink(
    'https://graphql.anilist.co',
  );

  static GraphQLClient client() {
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }
}
