import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_v2/data/DUMMY_DATA.dart';
import 'package:meals_app_v2/providers/favorites_provider.dart';
import 'package:meals_app_v2/providers/meals_provider.dart';

import 'package:meals_app_v2/screens/categories.dart';
import 'package:meals_app_v2/screens/filters.dart';
import 'package:meals_app_v2/screens/meals.dart';
import 'package:meals_app_v2/widgets/main_drawer.dart';

import 'package:meals_app_v2/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

const kInicialFIlters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  String activePageTitle = 'Pick your category';
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilter = ref.watch(filtersProvider);
    List<Meal> filteredMeals = meals.where(
      (meal) {
        if (!meal.isGlutenFree && activeFilter[Filter.glutenFree]!) {
          return false;
        }
        if (!meal.isLactoseFree && activeFilter[Filter.lactoseFree]!) {
          return false;
        }
        if (!meal.isVegan && activeFilter[Filter.vegan]!) {
          return false;
        }
        if (!meal.isVegetarian && activeFilter[Filter.vegetarian]!) {
          return false;
        }
        return true;
      },
    ).toList();

    Widget activePage = CategoriesScreen(
      availableFilteredMeals: filteredMeals,
    );

    void _setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        await Navigator.of(context).push<Map<Filter, bool>>(
            MaterialPageRoute(builder: ((context) => const FilterScreen())));
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
      );
      activePageTitle = 'Pick your category';
    }
    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
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
