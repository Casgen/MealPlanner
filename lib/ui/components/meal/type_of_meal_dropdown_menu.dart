import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';

class TypeOfMealDropDownMenu extends StatefulWidget {
  const TypeOfMealDropDownMenu({
    super.key,
    required this.onSelected,
  });

  final void Function(TypeOfMeal? typeOfMeal) onSelected;

  @override
  State<TypeOfMealDropDownMenu> createState() => _TypeOfMealDropDownMenu();

}

class _TypeOfMealDropDownMenu extends State<TypeOfMealDropDownMenu> {

  final TextEditingController typeOfMealController = TextEditingController();

  TypeOfMeal? selectedTypeOfMeal;

  @override
  Widget build(BuildContext context) {

    final List<DropdownMenuEntry<TypeOfMeal>> typeOfMealEntries = TypeOfMeal.values.map((e) {
      return DropdownMenuEntry<TypeOfMeal>(value: e, label: e.getName());
    }).toList();

    return DropdownMenu<TypeOfMeal>(
      controller: typeOfMealController,
      label: const Text("Type of meal"),
      dropdownMenuEntries: typeOfMealEntries,
      onSelected: (typeOfMeal) {
        setState(() {
          selectedTypeOfMeal = typeOfMeal;
        });

        widget.onSelected(typeOfMeal);
      },
    );
  }


}