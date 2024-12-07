import 'package:exemple2/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier() : super([]);

  bool togleMealFavorite(Meal meal) {
    final isFavoris = state.contains(meal);

    if (isFavoris) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealNotifier, List<Meal>>((ref) {return FavoriteMealNotifier();});


