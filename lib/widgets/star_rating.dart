import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    // Calculate the number of full stars
    int fullStars = (rating / 2).floor();
    // Calculate if there is a half star
    bool halfStar = ((rating / 2) % 1) >= 0.5;
    // Calculate the number of empty stars
    int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
            fullStars, (index) => const Icon(Icons.star, color: Colors.orange)),
        if (halfStar) const Icon(Icons.star_half, color: Colors.orange),
        ...List.generate(emptyStars,
            (index) => const Icon(Icons.star_border, color: Colors.orange)),
      ],
    );
  }
}
