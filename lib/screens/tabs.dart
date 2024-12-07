import 'package:exemple2/data/dummy_data.dart';
import 'package:exemple2/models/category.dart';
import 'package:exemple2/models/meal.dart';
import 'package:exemple2/provider/favorite_provider.dart';
import 'package:exemple2/provider/filters_providers.dart';
import 'package:exemple2/screens/categories.dart';
import 'package:exemple2/screens/filters.dart';
import 'package:exemple2/screens/meals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int ind = 0;

  @override
  Widget build(BuildContext context) {

  final availableMeals = ref.watch(filteredMealsProvider);

    var titre = 'Categories';
    Widget activeScreen = Categories(
      availableMeals: availableMeals,
    );

    if (ind == 1) {
      final List<Meal> favorisMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        filteredmeals: favorisMeals,
      );
      titre = 'Favoris';
    }

    
    return Scaffold(
      appBar: AppBar(
        title: Text(titre),
        backgroundColor: const Color.fromARGB(255, 51, 230, 140),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              //margin: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 239, 253, 229),
                  const Color.fromRGBO(174, 227, 84, 1)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Les plats",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            ListTile(
              tileColor: Colors.amber,
              leading: Icon(Icons.add),
              title: Text('Filtres'),
              subtitle: Text("Détails de l'utilisateur"), // Sous-titre
              trailing: Icon(Icons.arrow_forward), // Icône à la fin (flèche)
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.amberAccent,
              leading: Icon(Icons.add),
              title: Text('Retourner'),
              subtitle: Text("Page d'accueil"),
              trailing: Icon(Icons.reset_tv),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            ind = value;
          });
        },
        currentIndex: ind,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorite")
        ],
      ),
    );
  }
}
