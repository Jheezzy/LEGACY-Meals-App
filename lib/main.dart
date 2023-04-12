import 'package:flutter/material.dart';

import 'dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> availableMeals = dummyMeals;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals = dummyMeals.where((meal) {
        if (filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        if (filters['vegan']! && !meal.isVegan) {
          return false;
        }
        return true; // If i make it pass the if checks then i know it's either i'm satisfying
        //or switching those filters or I'm not in which case i want to display all the meals
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) {
      return meal.id == mealId;
    }); //this is just to get the index of a meal and equate it to the mealId we're getting and then save it in 'existingIndex'
    if (existingIndex >= 0) {
      // if it is >= 0 then obviously it is inside that list
      setState(() {
        favoriteMeals.removeAt(
            existingIndex); // now we use that existingIndex as the index of the meal to remove from the list
      });
    } else {
      setState(() {
        favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  } // when setState is called for this method and the build method is called and the entire app is rebuilt is not optimal cos why should adding something as favorite rebuild the whole app

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) =>
        meal.id ==
        id); // we're checking if the meal we're looking at with that id is a favorite
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(favoriteMeals), // 1
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals), // 2
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(toggleFavorite, isMealFavorite), // 3
        FiltersScreen.routeName: (context) =>
            FiltersScreen(filters, setFilters) // 4
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   // return MaterialPageRoute(builder: (context) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return const CategoriesScreen();
        });
      },
    );
  }
}

//* Now we want to work on the favorites feature and we want to display a text -
//* if we have no favorites and we want the user to be able to add favorites

//* How do we save or where do we save which item the user marked as favorite
//* Storing this on the meal itself by adding a bool isFavorite
//* on the meal model might not be perfect

//* So let's manage a list of favorite meals in main.dart
//* We now have to pass the list to favorites_screen, but we don't have it in our routes
//* because we have it under tabs_screen and since we have it in main.dart we pass the list to it
//* We then accept it in the tabs_screen and then pass it to favorites_screen there
//* and in turn we also have to accept it in favorites_screen itself

//* Now in the main.dart, we only need to add some logic -
//* to add or remove meals to and from the favorites
//* So we create a new void method then pass in mealId as argument -
//* because we will need the id of the meal to be removed or added as favorite
//* The goal now is to add it to the favoriteMeal list i created,
//* however of course only add if it is not already part of the list because if it is already part of the list,
//? this is where we use .indexWhere()
//* then i want to remove that meal because it's a toggle method that we should either add or remove
//

//* NOTE: You can't use the widget property when you initialize properties -
//* we can fix this by initializing those properties in initState instead
//
