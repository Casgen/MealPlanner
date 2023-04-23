import 'package:flutter/material.dart';

class IconToggleButton extends StatefulWidget {
  const IconToggleButton({super.key,
    required this.isToggledIcon,
    required this.notToggledIcon,
    required this.onChanged,
    this.initialValue
  });

  final Icon isToggledIcon;
  final Icon notToggledIcon;
  final bool? initialValue;
  final void Function(bool value) onChanged;

  @override
  State<IconToggleButton> createState() => _IconToggleButton();
}

class _IconToggleButton extends State<IconToggleButton> {

  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      isToggled = widget.initialValue!;
    }

  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onPressed,
      icon: _switchIcon(),
    );
  }

  void _onPressed() {
    setState(() {
      isToggled = !isToggled;
    });

    widget.onChanged(isToggled);
  }

  Icon _switchIcon() {
    if (isToggled) return widget.isToggledIcon;
    return widget.notToggledIcon;
  }

}