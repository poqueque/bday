import 'package:flutter/widgets.dart';

class Space extends StatelessWidget {
  final double size;

  Space({Key key, this.size = 8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(size));
  }
}
