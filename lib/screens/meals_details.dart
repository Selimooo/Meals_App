import 'dart:ffi';

import 'package:exemple2/models/meal.dart';
import 'package:exemple2/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsDetails extends ConsumerWidget {
  const MealsDetails({required this.meal, super.key});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal> list_favoris = ref.watch(favoriteMealsProvider);
    var isFavoris = list_favoris.contains(meal);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 230, 140),
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .togleMealFavorite(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    wasAdded ? 'Meal added as a favorite.' : 'Meal removed.'),
              ));
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavoris ? Icons.star : Icons.star_border_outlined,
                key: ValueKey((isFavoris)),

              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Ingredients',
              style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: TextStyle(color: Colors.black,
                   
                  ),
              ),
          ],
        ),
      ),
    );
  }
}
