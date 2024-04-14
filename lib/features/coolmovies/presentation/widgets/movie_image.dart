import 'package:flutter/material.dart';

class MovieImage extends StatelessWidget {
  final String tag;
  final String imagePath;

  const MovieImage({Key? key, required this.tag, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Hero(
          tag: tag,
          child: Image.network(
            imagePath,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
