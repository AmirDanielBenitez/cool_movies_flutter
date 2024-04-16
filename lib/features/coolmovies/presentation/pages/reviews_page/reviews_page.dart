import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:coolmovies/core/components/column_builder.dart';
import 'package:coolmovies/features/coolmovies/data/models/review/review_model.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserNotAuthenticated) {
            return const Center(
              child: Text(
                'You must login first',
                style: bigTitleTextStyle,
              ),
            );
          } else if (userState is UserAuthenticated) {
            return BlocBuilder<ReviewsBloc, ReviewsState>(
              bloc: BlocProvider.of<ReviewsBloc>(context)
                ..add(LoadReviewsByUserEvent(userId: userState.user.id)),
              builder: (context, state) {
                if (state is ReviewsInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReviewsLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('User reviews', style: bigTitleTextStyle),
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
                                    final Review review = state.reviews[index];
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
                                                Icons.movie_rounded,
                                                color: backgroundColor,
                                              ),
                                              const SizedBox(width: 5.0),
                                              Text(review.movieTitle,
                                                  style: titleBlackTextStyle),
                                            ],
                                          ),
                                        ),
                                        Text(review.title,
                                            style: titleBlackTextStyle),
                                        const SizedBox(height: 5.0),
                                        StarRating(
                                            rating: review.rating.toDouble()),
                                        const SizedBox(height: 5.0),
                                        Text(review.body),
                                      ],
                                    );
                                  },
                                  itemCount: state.reviews.length),
                            ),
                          ),
                        ),
                        const SizedBox(height: 75.0),
                      ],
                    ),
                  );
                }
                return Container();
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
