import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminClubScreen extends StatelessWidget {
  const AdminClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.teal,
        body: Column(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 60),
          ),
          Padding(
            padding: EdgeInsets.only(left: 280),
            child: IconButton(
                icon: const Icon(
                  Icons
                      .arrow_circle_right_outlined, //Padding(padding:EdgeInsets.only(left: 80),//),
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  // final route = MaterialPageRoute(
                  //   builder: (context) => ProfileScreenAdmin());
                  //  Navigator.push(context, route);
                }),
          ),
          Padding(
            padding: EdgeInsets.all(25),
          ),
          Expanded(
            child: Container(
                //child:const Padding(padding: const EdgeInsets.only(top: 40.0)),
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://googleflutter.com/sample_image.jpg")))),
          ),
          Padding(
              padding: EdgeInsets.all(30),
              child: Text('name',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
          Row(children: [
            Padding(padding: EdgeInsets.all(20)),
            Text('05888888    ',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            Text('43800XX    ',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            Text('name@gmail.com ',
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ]),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Container(
            padding: EdgeInsets.all(30),
            width: 410,
            height: 410,
            color: Colors.white,
            child: Column(children: [
              Card(
                margin: EdgeInsets.all(40),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 2)),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        color: Colors.teal,
                        padding: EdgeInsets.all(10),
                        child: Text('20',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                      Expanded(
                        child: Text('clubs',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15)),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 2)),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        color: Colors.teal,
                        padding: EdgeInsets.all(10),
                        child: Text('CV',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                      Expanded(
                        child: Text('name',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15)),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )
        ]));
  }
}
