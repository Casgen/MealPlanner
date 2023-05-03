import 'package:flutter/material.dart';
import 'package:umte_project/data/enums/unit.dart';

class AmountCounter extends StatefulWidget {
  const AmountCounter({
    super.key,
    required this.unit,
    this.onChanged,
    this.initialValue,
  });

  final int? initialValue;
  final Unit unit;
  final void Function(int value)? onChanged;

  @override
  State<StatefulWidget> createState() => _AmountCounter();
}

class _AmountCounter extends State<AmountCounter> {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle unitsStyle = theme.textTheme.titleLarge!
        .copyWith(
        color: theme.colorScheme.onSurface,
      );

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 50,
            minWidth: 20,
          ),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            initialValue: widget.initialValue?.toString(),
            keyboardType: TextInputType.number,
            onChanged: _onChanged,
          ),
        ),
        Icon(
          Icons.close_rounded,
          color: theme.colorScheme.onSurface,
        ),
        Baseline(
          baselineType: TextBaseline.alphabetic,
          baseline: 17,
          child: Text(
              widget.unit.getSymbol(),
              style: unitsStyle,
          ),
        )
      ],
    );
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) {
      if (value.isNotEmpty) {
        return widget.onChanged!(int.parse(value));
      }

      return widget.onChanged!(0);
    }
  }
}
