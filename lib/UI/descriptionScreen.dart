import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const DescriptionScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              image,
              width: 120,
              height: 170,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
              //    overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
