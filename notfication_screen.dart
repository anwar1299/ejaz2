import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'notifications',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            backgroundColor: Colors.teal,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ]),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, position) {
              return Column(
                children: [
                  Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 30,
                        ),
                        title: Text('Success',
                            style: const TextStyle(
                                color: Colors.green, fontSize: 15)),
                        onTap: () {},
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green, width: 1))),
                  Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.fiber_new_outlined,
                          color: Colors.blue,
                          size: 30,
                        ),
                        title: Text('new course',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 15)),
                        onTap: () {},
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 1))),
                  Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.adjust_rounded,
                          color: Colors.red,
                          size: 30,
                        ),
                        title: Text('warning',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 15)),
                        onTap: () {},
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red, width: 1))),
                  Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.error_outline,
                          color: Colors.amberAccent,
                          size: 30,
                        ),
                        title: Text('reminder',
                            style: const TextStyle(
                                color: Colors.amberAccent, fontSize: 15)),
                        onTap: () {},
                      ),
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Colors.amberAccent, width: 1))),
                ],
              );
            }));
  }
}
