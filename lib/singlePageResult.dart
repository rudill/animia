import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SingleChildScrollView singlePageSearchResult(data) {
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
              child: Image.network(
                data['coverImage']['extraLarge'] ??
                    data['coverImage']['large'],
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              width: 347,
              height: 60,
              decoration: ShapeDecoration(
                color: _parseHexColor(data['coverImage']['color']),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              child: Center(
                child: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Text(
                    data['title']['romaji'] ?? 'No Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // width: 347,
            // height: 60,


            child: Center(
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Text(
                  data['description'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Color _parseHexColor(String? hexColor) {
  if (hexColor == null || hexColor.isEmpty) {
    return Colors.grey; // Fallback color
  }

  try {
    // Remove the "#" if it exists and parse the color
    return Color(
        int.parse(hexColor.replaceFirst('#', ''), radix: 16) + 0xFF000000);
  } catch (e) {
    // If parsing fails, return a default color
    return Colors.grey;
  }
}
