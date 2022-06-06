import 'package:flutter/material.dart';

class CourseListItem extends StatelessWidget {
  final title;
  final date;
  final image;
  const CourseListItem({
    Key? key, required this.title, required this.date, required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: (){},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      //  height: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(date)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
