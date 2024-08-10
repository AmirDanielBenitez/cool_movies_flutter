import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:coolmovies/core/components/column_builder.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/features/coolmovies/data/models/review/review_model.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/star_rating.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/star_rating_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          ..add(LoadReviewsByMovieEvent(movieId: movie.id)),
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
                  state is ReviewsInitial
                      ? const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Transform.translate(
                          offset: const Offset(0, -50),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  color: backgroundCard,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        ).animate().fadeIn(duration: 300.ms).scale(),
                  if (state is ReviewsLoaded) ...[
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Reviews',
                                  style: bigTitleTextStyle,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: starColor),
                                  onPressed: () {
                                    showReviewDialog(context);
                                  },
                                  child: const Text(
                                    'Add review',
                                    style: titleTextStyle,
                                  ),
                                ),
                              ],
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

  Future<void> showReviewDialog(BuildContext context) async {
    String title = '';
    String body = '';
    double rating = 0.0;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        UserState userState = BlocProvider.of<UserBloc>(context).state;
        if (userState is UserNotAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You have to be logged to leave a review'),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          });
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Add Review'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    StarRatingReview(
                      rating: rating,
                      onTap: (newRating) {
                        setState(() {
                          rating = newRating;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Body'),
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {
                          body = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (title.isNotEmpty && body.isNotEmpty) {
                      BlocProvider.of<ReviewsBloc>(context).add(SendReviewEvent(
                        review: Review(
                            id: '',
                            title: title,
                            rating: rating.toInt(),
                            body: body,
                            movieData: MovieDataReview(movie.id, movie.title),
                            user: (userState as UserAuthenticated).user.id),
                      ));
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
