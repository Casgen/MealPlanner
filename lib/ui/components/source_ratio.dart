import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SourceRatio extends StatelessWidget {
  const SourceRatio({
    super.key,
    required this.denum,
    required this.num,
    required this.icon,
  });

  final double denum;
  final double num;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                "$num/$denum",
                style: theme.textTheme.labelLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
