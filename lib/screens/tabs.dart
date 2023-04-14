import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals_app_v2/screens/categories.dart';
import 'package:meals_app_v2/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  Widget activePage = const CategoriesScreen();
  String activePageTitle = 'Pick your category';
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _selectPage(int index) {
      setState(() {
        selectedPageIndex = index;
      });
    }

    if (selectedPageIndex == 0) {
      activePage = const CategoriesScreen();
      activePageTitle = 'Pick your category';
    }
    if (selectedPageIndex == 1) {
      activePage = const MealsScreen(meals: []);
      activePageTitle = 'Favorites';
    }

    return Scaffold(
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
