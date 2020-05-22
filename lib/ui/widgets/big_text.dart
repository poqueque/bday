import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String data;
  final TextAlign align;
  final TextStyle style;

  BigText(
    this.data, {
    this.align,
    TextStyle style = const TextStyle(),
  }) : style = style.copyWith(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: align,
      style: style,
    );
  }
}
