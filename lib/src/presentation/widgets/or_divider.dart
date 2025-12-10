import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final Color? lineColor;
  final double spacing;

  const OrDivider({
    super.key,
    this.text = "OR",
    this.lineColor,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    final color = lineColor ?? Colors.grey[400];

    return Row(
      children: [
        Expanded(child: Divider(color: color)),
        SizedBox(width: spacing),
        Text(text),
        SizedBox(width: spacing),
        Expanded(child: Divider(color: color)),
      ],
    );
  }
}