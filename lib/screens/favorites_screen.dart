import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty
        ? Center(
            child: const Text('You have no favorites yet - start adding some!'),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                id: favoriteMeals[index].id,
                title: favoriteMeals[index].title,
                imageUrl: favoriteMeals[index].imageUrl,
                duration: favoriteMeals[index].duration,
                complexity: favoriteMeals[index].complexity,
                affordability: favoriteMeals[index].affordability,
              );
            },
            itemCount: favoriteMeals.length,
          );
  }
  // if (favoriteMeals.isEmpty) {
  //   return Center(
  //     child: Text('You have no favorites yet - start adding some!'),
  //   );
  // } else {
  //   return ListView.builder(
  //     itemBuilder: (context, index) {
  //       return MealItem(
  //         id: favoriteMeals[index].id,
  //         title: favoriteMeals[index].title,
  //         imageUrl: favoriteMeals[index].imageUrl,
  //         duration: favoriteMeals[index].duration,
  //         complexity: favoriteMeals[index].complexity,
  //         affordability: favoriteMeals[index].affordability,
  //       );
  //     },
  //     itemCount: favoriteMeals.length,
  //   );
  // }
}


//* On the favorites screen I want to check if there are any favorites