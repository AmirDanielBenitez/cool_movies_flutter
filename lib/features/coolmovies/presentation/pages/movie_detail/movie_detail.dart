import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:coolmovies/core/components/column_builder.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/features/coolmovies/data/models/review/review_model.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        bloc: BlocProvider.of<ReviewsBloc>(context)
          ..add(LoadReviewsEvent(movieId: movie.id)),
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/movie-image',
                              arguments: {
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
                                backgroundColor:
                                    backgroundColor.withOpacity(0.5),
                                foregroundColor: Colors.white,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            color: backgroundCard,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.title,
                                    textAlign: TextAlign.center,
                                    style: bigTitleTextStyle),
                                const SizedBox(height: 5.0),
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
                                const SizedBox(height: 5.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text.rich(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state is ReviewsLoaded) ...[
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Reviews',
                                style: bigTitleTextStyle,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Card(
                                margin: EdgeInsets.zero,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: ColumnBuilder(
                                      itemBuilder: (context, index) {
                                        final Review review =
                                            state.reviews[index];
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            index == 0
                                                ? Container()
                                                : const Divider(
                                                    color: backgroundColor,
                                                    thickness: 1.0,
                                                  ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .account_circle_rounded,
                                                    color: backgroundColor,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(review.user,
                                                      style:
                                                          titleBlackTextStyle),
                                                ],
                                              ),
                                            ),
                                            Text(review.title,
                                                style: titleBlackTextStyle),
                                            const SizedBox(height: 5.0),
                                            StarRating(
                                                rating:
                                                    review.rating.toDouble()),
                                            const SizedBox(height: 5.0),
                                            Text(review.body),
                                          ],
                                        );
                                      },
                                      itemCount: state.reviews.length),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
