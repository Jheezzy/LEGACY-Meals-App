import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final void Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilter;

  const FiltersScreen(this.currentFilter, this.saveFilters, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var glutenFree = false;
  var vegetarian = false;
  var vegan = false;
  var lactoseFree = false;

  @override
  void initState() {
    super.initState();
    glutenFree = widget.currentFilter['gluten']!;
    lactoseFree = widget.currentFilter['lactose']!;
    vegetarian = widget.currentFilter['vegetarian']!;
    vegan = widget.currentFilter['vegan']!;
  }

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, void Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    var newFilters = {
      'gluten': glutenFree,
      'lactose': lactoseFree,
      'vegetarian': vegetarian,
      'vegan': vegan,
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () => widget.saveFilters(newFilters),
            icon: const Icon(Icons.save),
            padding: const EdgeInsets.symmetric(horizontal: 15),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile('Gluten-free',
                    'Only include gluten-free meals.', glutenFree, (newValue) {
                  setState(() {
                    glutenFree = newValue;
                  });
                }),
                buildSwitchListTile(
                    'Lactose-free',
                    'Only include lactose-free meals.',
                    lactoseFree, (newValue) {
                  setState(() {
                    lactoseFree = newValue;
                  });
                }),
                buildSwitchListTile(
                    'Vegetarian', 'Only include vegetarian meals.', vegetarian,
                    (newValue) {
                  setState(() {
                    vegetarian = newValue;
                  });
                }),
                buildSwitchListTile('Vegan', 'Only include vegan meals.', vegan,
                    (newValue) {
                  setState(() {
                    vegan = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
