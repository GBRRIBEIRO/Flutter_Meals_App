import 'package:flutter/material.dart';
import 'package:meals_app_v2/data/DUMMY_DATA.dart';
import 'package:meals_app_v2/models/category.dart';
import 'package:meals_app_v2/screens/meals.dart';
import 'package:meals_app_v2/widgets/category_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _openCategory(BuildContext context, Category category) {
    final categoryMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MealsScreen(
              title: category.title,
              meals: categoryMeals,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //Set the max columns
          childAspectRatio: 3 / 2, //Set the aspect ratio
          crossAxisSpacing: 20, //Set spacing in the cross axis
          mainAxisSpacing: 20, //Set spacing in the main axis
        ),
        children: [
          ...availableCategories.map((cat) {
            return CategoryGridItem(
              category: cat,
              onTapFunction: () => _openCategory(context, cat),
            );
          })
        ],
      ),
    );
  }
}
