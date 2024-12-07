import 'package:exemple2/models/meal.dart';
import 'package:exemple2/screens/meals_details.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({this.titre, required this.filteredmeals, super.key});
  final List<Meal> filteredmeals;
  final String? titre;

  void _selectdetailsmeals(BuildContext context, Meal meal) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => MealsDetails(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      color:Colors.greenAccent,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 40,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Nothing here !",
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );

    if (filteredmeals.isNotEmpty) {
      content = Scaffold(
        backgroundColor: Colors.greenAccent,
        body: ListView.builder(
            itemCount: filteredmeals.length,
            itemBuilder: (ctx, index) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      _selectdetailsmeals(context, filteredmeals[index]);
                    },
                    child: Stack(
                      children: [
                        Hero(
                          tag: filteredmeals[index].id,
                          child: Image.network(
                            filteredmeals[index].imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            child: Column(
                              children: [
                                Text(
                                  filteredmeals[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      '${filteredmeals[index].duration} min',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      Icons.work,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      '${filteredmeals[index].complexity.name[0].toUpperCase() + filteredmeals[index].complexity.name.substring(1)}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      Icons.attach_money,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      '${filteredmeals[index].affordability.name[0].toUpperCase() + filteredmeals[index].affordability.name.substring(1)}',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
      );
    }

    if (titre == null) {
      return content;
    }
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(titre!),
        backgroundColor: const Color.fromARGB(255, 51, 230, 140),
      ),
      body: content,
    );
  }
}
