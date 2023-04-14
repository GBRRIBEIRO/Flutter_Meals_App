import 'package:flutter/material.dart';
import 'package:meals_app_v2/screens/meal_details.dart';
import 'package:meals_app_v2/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem(this.meal, {super.key, required this.onToggleFavorite});
  final Meal meal;

  final void Function(Meal meal) onToggleFavorite;

  String get getComplexityString {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get getAffordabilityString {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  void _goToMealDetailsScreen(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MealDetailsScreen(meal, onToggleFavorite)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //Cuts everything that "overflow the edges"
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: () => _goToMealDetailsScreen(context, meal),
        child: Stack(
          children: [
            FadeInImage(
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl)),
            Positioned(
              //This is like a "padding"
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                //Transparent black
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true, //Good wraping
                      overflow: TextOverflow
                          .ellipsis, //If it's very long, it puts "..."
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: '$getComplexityString min',
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: getAffordabilityString,
                        ),
                      ],
                    )
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
