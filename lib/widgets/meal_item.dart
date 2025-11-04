import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final Function(BuildContext context, Meal meal) onSelectMeal;

  IconData _complexityIcon(Complexity complexity) {
    return switch (complexity) {
      Complexity.simple => Icons.signal_cellular_alt_1_bar_rounded,
      Complexity.challenging => Icons.signal_cellular_alt_2_bar_rounded,
      Complexity.hard => Icons.signal_cellular_alt_rounded,
    };
  }

  final Widget _spacing = const Row(
    children: [
      SizedBox(width: 6),
      Text(
        '|',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: 6),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(context, meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 1],
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 34,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.watch_later_outlined,
                          label: '${meal.duration} min',
                        ),
                        _spacing,
                        MealItemTrait(
                          icon: _complexityIcon(meal.complexity),
                          label: meal.complexity.name,
                        ),
                        _spacing,
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: meal.affordability.name,
                        ),
                      ],
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
