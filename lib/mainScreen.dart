import 'package:animia/graphql_config.dart';
import 'package:animia/quaries.dart';
import 'package:animia/singlePageResult.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphqlProvider.dart';

class animaMainScreen extends StatelessWidget {
  //final int aniId;
  final String aniName;
  const animaMainScreen({super.key, required this.aniName});

  @override
  Widget build(BuildContext context) {
    return buildGraphQLProvider();
  }


}
