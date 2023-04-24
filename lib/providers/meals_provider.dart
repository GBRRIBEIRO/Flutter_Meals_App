import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_v2/data/DUMMY_DATA.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
