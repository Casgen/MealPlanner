import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';

class SourceRatio extends StatefulWidget {
  const SourceRatio({
    super.key,
    required this.denum,
    required this.value,
    required this.image,
    required this.unitStr,
    required this.isRealNum,
  });

  final double denum;
  final double value;
  final AssetImage image;
  final String unitStr;
  final bool isRealNum;

  @override
  State<SourceRatio> createState() => _SourceRatioState();
}

class _SourceRatioState extends State<SourceRatio> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String ratioString;
    if (widget.isRealNum) {
      ratioString = format("{:.1f}/{:.1f} {2}", widget.value, widget.denum, widget.unitStr);
    } else {
      ratioString = format("{:d}/{:d} {2}", widget.value.toInt(), widget.denum.toInt(), widget.unitStr);
    }

    return Card(
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: widget.image, width: 20, height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                ratioString,
                style: theme.textTheme.titleMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
