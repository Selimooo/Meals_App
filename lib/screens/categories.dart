import 'package:exemple2/data/dummy_data.dart';
import 'package:exemple2/models/category.dart';
import 'package:exemple2/models/meal.dart';
import 'package:exemple2/screens/meals.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({required this.availableMeals, super.key});
  final List<Meal> availableMeals;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectcat(BuildContext context, Category cat) {
    final filteredmeals = widget.availableMeals
        .where((meal) => meal.categories.contains(cat.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              titre: cat.title,
              filteredmeals: filteredmeals,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 240, 178, 178),
          const Color.fromARGB(255, 125, 159, 218),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final cat in availableCategories)
              InkWell(
                onTap: () {
                  _selectcat(context, cat);
                },
                splashColor: Colors.amber,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cat.color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: Text(
                    cat.title,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              )
          ],
        ),
      ),
      builder: (ctx, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
