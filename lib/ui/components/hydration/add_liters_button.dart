import 'package:flutter/material.dart';

class LitersButton extends StatelessWidget {
  const LitersButton(
      {super.key,
      required this.liters,
      required this.onRemoveLiters,
      required this.onAddLiters});

  final void Function(double liters) onRemoveLiters;
  final void Function(double liters) onAddLiters;
  final double liters;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle = theme.textTheme.titleMedium!
        .copyWith(color: theme.colorScheme.onSurface);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => onAddLiters(liters),
                child: Icon(
                  size: 30,
                  Icons.add,
                  color: theme.colorScheme.onSurface,
                )
            ),
            Text("$liters l", style: textStyle),
            TextButton(
                onPressed: () => onRemoveLiters(liters),
                child: Icon(
                  size: 30,
                  Icons.remove,
                  color: theme.colorScheme.onSurface,
                )
            )
          ],
        ),
      ),
    );
  }
}
