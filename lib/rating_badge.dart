import 'package:flutter/material.dart';

// Завдання 2. Незмінний повторно використовуваний віджет.
class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.rating, this.label})
      : assert(rating >= 0.0 && rating <= 5.0);

  final double rating;
  final String? label;

  Color get _starColor {
    if (rating >= 4.0) return Colors.green;
    if (rating >= 2.5) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    // Додаткова перевірка працює і в release, де assert вимкнено.
    if (!rating.isFinite || rating < 0.0 || rating > 5.0) {
      throw RangeError.range(rating, 0, 5, 'rating');
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: _starColor),
            const SizedBox(width: 4),
            Text(rating.toStringAsFixed(1)),
          ],
        ),
        if (label != null) ...[
          const SizedBox(height: 4),
          Text(label!),
        ],
      ],
    );
  }
}
