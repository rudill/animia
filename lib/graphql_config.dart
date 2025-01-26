import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main () async {

  await initHiveForFlutter();
  final HttpLink httpLink = HttpLink(
      'https://graphql.anilist.co',
  );

  // ValueNotifier<GraphQLClient> client = ValueNotifier(
  //   GraphQLClient(
  //     cache: GraphQLCache(store: HiveStore()), link: httpLink
  //   )
  // );

}