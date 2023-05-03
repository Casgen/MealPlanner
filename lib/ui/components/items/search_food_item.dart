import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/state/app_state.dart';
import 'package:umte_project/ui/screens/food_info_screen.dart';

class SearchFoodItem extends StatefulWidget {
  const SearchFoodItem(
      {super.key,
      required this.addMode,
      required this.food,
      this.onAdd,
      this.onRemove});

  final bool addMode;
  final Food food;
  final void Function(Food)? onAdd;
  final void Function(Food)? onRemove;

  @override
  State<SearchFoodItem> createState() => _SearchFoodItem();
}

class _SearchFoodItem extends State<SearchFoodItem> {
  final double _iconSize = 30.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return ListTile(
          title: Row(
            children: [
              Text(widget.food.name),
              const Spacer(),
              appState.foodIngredients.contains(widget.food)
                  ? IconButton(
                      iconSize: _iconSize,
                      color: Colors.redAccent,
                      onPressed: () => _onRemove(appState),
                      icon: const Icon(Icons.remove))
                  : IconButton(
                      iconSize: _iconSize,
                      color: Colors.greenAccent,
                      onPressed: () => _onAdd(appState),
                      icon: const Icon(Icons.add))
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FoodInfoScreen(
                      food: widget.food,
                    )));
          },
        );
      },
    );
  }

  void _onAdd(AppState appState) {
    appState.addFoodIngredient(widget.food);
    
    if (widget.onAdd != null) {
      widget.onAdd!(widget.food);
    }
  }

  void _onRemove(AppState appState) {
    appState.removeFoodIngredient(widget.food);
    
    if (widget.onRemove != null) {
      widget.onRemove!(widget.food);
    }
  }
}
