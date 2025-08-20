import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task2/canvas/ccanvas.dart';
import 'package:task2/shapes/ishape.dart';
import 'package:task2/utils/parser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final shapes = await loadShapesFromFile('assets/artwork.txt');

  runApp(MyApp(shapes: shapes));
}

Future<List<IShape>> loadShapesFromFile(String path) async {
  try {
    final data = await rootBundle.loadString(path);
    return data.split('\n').map(parseShape).whereType<IShape>().toList();
  } catch (e) {
    debugPrint('Error loading shapes: $e');
    return [];
  }
}

class MyApp extends StatelessWidget {
  final List<IShape> shapes;

  const MyApp({super.key, required this.shapes});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: CustomPaint(painter: ArtworkPainter(shapes))),
    );
  }
}

class ArtworkPainter extends CustomPainter {
  final List<IShape> shapes;

  ArtworkPainter(this.shapes);

  @override
  void paint(Canvas canvas, Size size) {
    final cCanvas = CCanvas(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    for (final shape in shapes) {
      shape.draw(cCanvas);
    }
  }

  @override
  bool shouldRepaint(ArtworkPainter oldDelegate) => false;
}
