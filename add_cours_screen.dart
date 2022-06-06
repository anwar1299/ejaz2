import 'package:flutter/material.dart';

class AddCoursScreen extends StatelessWidget {
  const AddCoursScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: ClipPath(
            clipper: MyTriangle(),
            child: Container(
              color: Colors.white,
              width: 500,
              height: 500,
            ),
          ),
        ));
  }
}

// Define MyTriangle class
class MyTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon([
      Offset(0, size.height),
      Offset(size.width / 2, 0),
      Offset(size.width, size.height)
    ], true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
