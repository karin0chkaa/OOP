import 'dart:ui';

import 'package:task2/canvas/icanvas_drawable.dart';

abstract interface class IShape implements ICanvasDrawable {
  double getArea();

  double getPerimeter();

  Color getOutlineColor();

  @override
  String toString();
}

abstract interface class ISolidShape implements IShape {
  Color getFillColor();
}
