import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie_model.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/star_rating.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(movie.title),
      // ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/movie-image', arguments: {
                        'tag': 'hero-image:${movie.id}',
                        'imagePath': movie.imgUrl
                      });
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Hero(
                        tag: 'hero-image:${movie.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            movie.imgUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ElevatedButton(
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
                        )),
                  )
                ],
              ),
              Transform.translate(
                offset: const Offset(
                    0, -50), // Mueve el contenedor hacia arriba 50px
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        color: backgroundCard,
                        width: double.infinity,
                        // height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movie.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            const Row(
                              children: [
                                Text(
                                  '5.0',
                                  style: TextStyle(
                                      color: starColor,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5.0),
                                StarRating(rating: 5.0),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Release Date: ',
                                      style: titleTextStyle,
                                    ),
                                    TextSpan(
                                      text: movie.releaseDate,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
