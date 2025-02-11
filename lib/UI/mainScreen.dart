import 'package:animia/graphqlFiles/graphql_config.dart';
import 'package:animia/graphqlFiles/quaries.dart';
import 'package:animia/UI/singlePageResult.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphqlFiles/graphqlProvider.dart';

class animaMainScreen extends StatelessWidget {
  //final int aniId;
  final String aniName;
  const animaMainScreen({super.key, required this.aniName});

  @override
  Widget build(BuildContext context) {
    return buildGraphQLProvider();
  }


}
