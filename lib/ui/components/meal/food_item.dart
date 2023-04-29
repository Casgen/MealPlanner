import 'package:flutter/material.dart';
import 'package:umte_project/database/database.dart';

class FoodItem extends StatefulWidget {
  const FoodItem({
    super.key,
    required this.food,
    required this.amount,
    required this.isChecked,
  });

  final Food food;
  final int amount;
  final bool isChecked;


  @override
  State<StatefulWidget> createState() => _FoodItem();
}

class _FoodItem extends State<FoodItem> {

  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

    if (widget.isChecked) _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSurface
    );

    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
        Text(widget.amount.toString(), style: style),
        const Icon(Icons.close_rounded, size: 15),
        Text(widget.food.unit.getSymbol(), style: style),
        const Spacer(flex: 1),
        Text(widget.food.name, style: style),
        Checkbox(
            autofocus: true,
            value: _isChecked,
            onChanged: (bool? newValue) {
              setState(() {
                _isChecked = newValue!;
              });
            }),
      ],
    );
  }

}






