import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/movie_card_shimmer.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/movie-detail', arguments: movie);
      },
      child: SizedBox(
        height: 250.0,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 170,
                  color: backgroundCard,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, bottom: 18.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150.0,
                      height: 232.0,
                      child: Hero(
                        tag: 'hero-image:${movie.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            movie.imgUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const ShimmerBox(
                                width: 150.0,
                                height: 232.0,
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 150.0,
                                height: 232.0,
                                color: Colors.grey[300], // Fondo gris
                                child: const Center(
                                  child: Text(
                                    'Offline',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          height: 152,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                movie.title,
                                style: titleTextStyle,
                              ),
                              Text.rich(
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
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Director: ',
                                      style: titleTextStyle,
                                    ),
                                    TextSpan(
                                      text: movie.director,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
