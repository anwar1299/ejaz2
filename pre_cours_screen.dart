import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cours_screen.dart';

class PreCoursScreen extends StatelessWidget {
  const PreCoursScreen({Key? key}) : super(key: key);

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
                style: TextStyle(color: Colors.white54, fontSize: 17),
              ),
              onPressed: () {
                final route =
                    MaterialPageRoute(builder: (context) => CoursScreen());
                Navigator.push(context, route);
              },
            ),
            TextButton(
              child: Text(
                'previous courses',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {},
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
                    // padding: EdgeInsets.all(10),
                    //color: Colors.white,
                    width: 150,
                    height: 168,

                    child:
                        //child:
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            elevation: 30,

                            // child:  InkWell(
                            // onTap: (){final route= MaterialPageRoute(builder: (context)=>ProfileClupScreen1());
                            // Navigator.push(context, route);},
                            child: Column(
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/image/m.jpeg',
                                    width: 70, height: 40, fit: BoxFit.fill),
                                const ListTile(
                                  //leading: Icon(Icons.album, size: 70),
                                  title: Text('cours',
                                      style: TextStyle(
                                          color: Colors.teal, fontSize: 14)),
                                  subtitle: Text('date:08764332',
                                      style: TextStyle(
                                          color: Colors.teal, fontSize: 14)),
                                ),
                                ButtonTheme(
                                    minWidth: 45,
                                    height: 25,
                                    child: RaisedButton(
                                      child: Text('report',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12)),
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: Colors.amber,
                                      elevation: 5,
                                    ))
                              ],
                            )),
                  ),
                  Container(

                      //padding: EdgeInsets.all(16.0),
                      width: 150,
                      height: 168,
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
                                      width: 70, height: 40, fit: BoxFit.fill),
                                  const ListTile(
                                    //leading: Icon(Icons.album, size: 70),
                                    title: Text('cours',
                                        style: TextStyle(
                                            color: Colors.teal, fontSize: 14)),
                                    subtitle: Text('date:08764332',
                                        style: TextStyle(
                                            color: Colors.teal, fontSize: 14)),
                                  ),
                                  ButtonTheme(
                                      minWidth: 45,
                                      height: 25,
                                      child: RaisedButton(
                                        child: Text('report',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12)),
                                        onPressed: () {},
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: Colors.amber,
                                        elevation: 5,
                                      ))
                                ],
                              )))),
                ]);
              },
            ),
          ),
        ]));
  }
}
