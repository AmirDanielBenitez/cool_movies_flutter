import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:flutter/material.dart';

class MovieImage extends StatelessWidget {
  final String tag;
  final String imagePath;

  const MovieImage({Key? key, required this.tag, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Hero(
                tag: tag,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: backgroundColor.withOpacity(0.5),
                foregroundColor: Colors.white,
              ),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
