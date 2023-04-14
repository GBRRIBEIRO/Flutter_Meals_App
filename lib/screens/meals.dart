import 'package:flutter/material.dart';
import 'package:meals_app_v2/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    var thisTheme = Theme.of(context);

    //onBackground is a color that is very visible compared to the theme's background
    var bodyLargeVisible = thisTheme.textTheme.bodyLarge!.copyWith(
      color: thisTheme.colorScheme.onBackground,
    );

    //content is a variable that contains all the content
    //If the list is not empty:
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: ((context, index) => MealItem(meals[index])));

    //If the list is empty:
    if (meals.isEmpty) {
      content = Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Nothing here',
            style: bodyLargeVisible,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting another one...',
            style: bodyLargeVisible,
          ),
        ]),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: content,
    );
  }
}
