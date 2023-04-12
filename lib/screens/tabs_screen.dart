import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages = [];
  int selectedPageIndex = 0;
  //  To know which page was selected

  @override
  void initState() {
    super.initState();
    pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorites',
      },
    ];
  }
  // 3. We now want to manage the list of widgets we want to render
  // 4. pages provides the data to use, but now we need to know which data to use

  void selectPage(int index) {
    // int selectedNavBarItemIndex = index;
    setState(() {
      selectedPageIndex = index;
      // Now we want to relate the index of the selected page to the index of the selected navbar item
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[selectedPageIndex]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: (pages[selectedPageIndex]['page'] as Widget),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black87,
        selectedItemColor: Colors.white,
        // selectedFontSize: 14,
        // unselectedFontSize: 14,
        currentIndex: selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
  // 1. Now we know what was selected, we know which bottomNavBarItem was selected with the help of index
  // 2. Next we need to set what to display, remember we still have to pass this function to onTap