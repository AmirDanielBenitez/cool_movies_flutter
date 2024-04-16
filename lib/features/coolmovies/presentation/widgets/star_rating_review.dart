import 'package:flutter/material.dart';

class StarRatingReview extends StatefulWidget {
  final double rating;
  final double starSize;
  final ValueChanged<double>? onTap;

  const StarRatingReview({
    Key? key,
    required this.rating,
    this.starSize = 30.0,
    this.onTap,
  }) : super(key: key);

  @override
  State<StarRatingReview> createState() => _StarRatingReviewState();
}

class _StarRatingReviewState extends State<StarRatingReview> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    int numberOfFullStars = _currentRating.floor();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        bool isFull = index < numberOfFullStars;
        return InkWell(
          onTap: () {
            double newRating = index + 1.0;
            setState(() {
              _currentRating = newRating;
            });
            if (widget.onTap != null) {
              widget.onTap!(newRating);
            }
          },
          child: Icon(
            isFull ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: widget.starSize,
          ),
        );
      }),
    );
  }
}
