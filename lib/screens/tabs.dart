import 'package:flutter/material.dart';
import 'package:meals_app_v2/data/DUMMY_DATA.dart';

import 'package:meals_app_v2/screens/categories.dart';
import 'package:meals_app_v2/screens/filters.dart';
import 'package:meals_app_v2/screens/meals.dart';
import 'package:meals_app_v2/widgets/main_drawer.dart';

import '../models/meal.dart';

const kInicialFIlters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  String activePageTitle = 'Pick your category';
  int selectedPageIndex = 0;

  Map<Filter, bool> _selectedFilters = kInicialFIlters;

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
    List<Meal> filteredMeals = dummyMeals.where(
      (meal) {
        if (!meal.isGlutenFree && _selectedFilters[Filter.glutenFree]!) {
          return false;
        }
        if (!meal.isLactoseFree && _selectedFilters[Filter.lactoseFree]!) {
          return false;
        }
        if (!meal.isVegan && _selectedFilters[Filter.vegan]!) {
          return false;
        }
        if (!meal.isVegetarian && _selectedFilters[Filter.vegetarian]!) {
          return false;
        }
        return true;
      },
    ).toList();

    Widget activePage = CategoriesScreen(
      availableFilteredMeals: filteredMeals,
      onToggleFavorite: _toggleFavorite,
    );

    void _setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
            MaterialPageRoute(builder: ((context) => const FilterScreen())));

        setState(() {
          _selectedFilters = result ?? kInicialFIlters;
        });
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
        availableFilteredMeals: filteredMeals,
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
