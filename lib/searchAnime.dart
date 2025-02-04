import 'package:flutter/material.dart';

Widget buildSearchResults() {
  return ListView.builder(
    itemCount: 3,
    itemBuilder: (BuildContext context, index) {
      return const ListTile(
        title: Text(
          "hello"
        ),
      );
    },
  );
}
