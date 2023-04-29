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

    final List<DropdownMenuItem<TypeOfMeal>> typeOfMealItems = TypeOfMeal.values.map((e) {
      return DropdownMenuItem<TypeOfMeal>(
          value: e,
          child: Text(e.getName()),
        );
    }).toList();

    return DropdownButton(
      items: typeOfMealItems,
      value: selectedTypeOfMeal,
      onChanged: (typeOfMeal) {
        setState(() {
          selectedTypeOfMeal = typeOfMeal;
        });

        widget.onSelected(typeOfMeal);
      },
    );
  }


}
