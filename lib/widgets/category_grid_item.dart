import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meals_app_v2/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final void Function() onTapFunction;

  const CategoryGridItem(
      {super.key, required this.category, required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
