import 'package:flutter/material.dart';

import 'course_list_item.dart';
import 'notfication_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text(this.title,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.add_alert_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {final route= MaterialPageRoute(builder: (context)=>NotificationScreen());
                Navigator.push(context, route);}, //هنا بعدين لمن اربط الصفحات
              ),
            ]),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                //flex: 2,
                child: Column(
                  children: [
                    Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Text(
                            'Climb the ladder of success and make your mark',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20,
                            ))),
                    Center(child: Image.asset('assets/image/m.jpeg')),
                    const Text(
                      "New training courses",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color:  Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                padding: EdgeInsets.symmetric(vertical: 50,horizontal: 0),
                child: ListView.builder(
                  itemCount: 10,
                  itemExtent: 200,
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: true ,
                  itemBuilder: (build, index) {
                    return CourseListItem(title:'Course ${index}',date:'35453453',image:'https://picsum.photos/200');
                  },
                ),
              ),
            ]));
  }


}


