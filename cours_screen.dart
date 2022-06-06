import 'package:app/ui/pages/pre_cours_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoursScreen extends StatelessWidget {
  const CoursScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
            titleTextStyle: TextStyle(color: Colors.teal, fontSize: 18),
            title: Text('Club training courses'),
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.teal,
                  size: 30,
                ),
                onPressed: () {
                  // final route = MaterialPageRoute(
                  //     builder: (context) => ClubProfilePage());
                  // Navigator.push(context, route);
                },
              ),
            ]),
        body: Column(children: [
          Row(//mainAxisSize: MainAxisSize.min,
              children: [
            Padding(padding: EdgeInsets.all(20)),
            TextButton(
              child: Text(
                'current courses    ',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {},
            ),
            TextButton(
              child: Text(
                'previous courses',
                style: TextStyle(color: Colors.white54, fontSize: 17),
              ),
              onPressed: () {
                final route =
                    MaterialPageRoute(builder: (context) => PreCoursScreen());
                Navigator.push(context, route);
              },
            ),
          ]),
          SizedBox(
            height: 620,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, position) {
                return Row(mainAxisSize: MainAxisSize.min, children: [
                  Padding(padding: EdgeInsets.all(25)),
                  Container(
                    //padding: p,
                    //padding: EdgeInsets.all(16.0),
                    width: 150,
                    height: 130,

                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      elevation: 30,
                      child: InkWell(
                          onTap: () {
                            // final route = MaterialPageRoute(
                            //     builder: (context) => ClubProfilePage());
                            // Navigator.push(context, route);
                          },
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset('assets/image/m.jpeg',
                                  width: 70, height: 50, fit: BoxFit.fill),
                              const ListTile(
                                //leading: Icon(Icons.album, size: 70),
                                title: Text('cours',
                                    style: TextStyle(color: Colors.teal)),
                                subtitle: Text('date:08764332',
                                    style: TextStyle(color: Colors.teal)),
                              )
                            ],
                          )),
                    ),
                  ),
                  Container(

                      //padding: EdgeInsets.all(16.0),
                      width: 150,
                      height: 130,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          elevation: 10,
                          child: InkWell(
                              onTap: () {
                                // final route = MaterialPageRoute(
                                //     builder: (context) => ClubProfilePage());
                                // Navigator.push(context, route);
                              },
                              child: Column(
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset('assets/image/m.jpeg',
                                      width: 70, height: 50, fit: BoxFit.fill),
                                  const ListTile(
                                    //leading: Icon(Icons.album, size: 70),
                                    title: Text('cours',
                                        style: TextStyle(
                                            color: Colors.teal, fontSize: 14)),
                                    subtitle: Text('date:08764332',
                                        style: TextStyle(
                                            color: Colors.teal, fontSize: 14)),
                                  ),
                                ],
                              )))),
                ]);
              },
            ),
          ),
          //bottomNavigationBar
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.amber,
                  textColor: Colors.black,
                  child: Text('Add a new course'),
                  elevation: 5,
                ),
              ))
        ]));
  }
}
