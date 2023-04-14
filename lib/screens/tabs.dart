import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals_app_v2/data/DUMMY_DATA.dart';
import 'package:meals_app_v2/screens/categories.dart';
import 'package:meals_app_v2/screens/meals.dart';
import 'package:meals_app_v2/widgets/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  String activePageTitle = 'Pick your category';
  int selectedPageIndex = 0;

  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(Meal meal) {
    var isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      _showSnackbar('Removed from favorites');
      setState(() {
        _favoriteMeals.remove(meal);
      });
    } else {
      _showSnackbar('Added to favorites');
      setState(() {
        _favoriteMeals.add(meal);
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavorite,
    );

    void _setScreen(String identifier) {
      if (identifier == 'filters') {
      } else {
        Navigator.of(context).pop();
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _selectPage(int index) {
      setState(() {
        selectedPageIndex = index;
      });
    }

    if (selectedPageIndex == 0) {
      activePage = CategoriesScreen(
        onToggleFavorite: _toggleFavorite,
      );
      activePageTitle = 'Pick your category';
    }
    if (selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavorite,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
