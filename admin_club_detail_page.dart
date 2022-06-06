import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminClubDetailPage extends StatelessWidget {
  const AdminClubDetailPage({Key? key, required this.club}) : super(key: key);
  final QueryDocumentSnapshot club;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // extended floating action button
        floatingActionButton: FutureBuilder<bool>(
            future: FirebaseServices().isSubscribedToClub(club),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final isSubscribed = snapshot.data ?? false;
                return FloatingActionButton.extended(
                  label: isSubscribed ? Text('Unsubscribe') : Text('Subscribe'),
                  backgroundColor: Colors.amber,
                  onPressed: () {
                    if (isSubscribed) {
                      final bool = FirebaseServices().unsubscribe(club);
                      // show a snackbar
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Unsubscribed from ${club['name']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red));
                    } else {
                      final bool = FirebaseServices().subscribe(club);
                      // show a snackbar
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Subscribed to ${club['name']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green));
                    }
                  },
                );
              } else {
                return Container();
              }
              // return FloatingActionButton.extended(
              //   backgroundColor: Colors.amber,
              //   label: Text('Subscription'),
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/admin/club/edit', arguments: club);
              //   },
              // );
            }),
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
                onPressed: () {}),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Expanded(
            child: Container(
                //child:const Padding(padding: const EdgeInsets.only(top: 40.0)),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(club['image'] ??
                            'https://www.w3schools.com/howto/img_avatar.png')))),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text('${club['name']}',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Text('${club['description']}',
                    style: TextStyle(color: Colors.white, fontSize: 20))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Container(
            padding: EdgeInsets.all(30),
            width: 800,
            height: 500,
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
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseServices()
                              .getUserData(club['supervisor']),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!.get('name'),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
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
                  onTap: () {
                    Navigator.pushNamed(context, '/club_courses',
                        arguments: club.id);
                  },
                  child: Row(
                    children: [
                      Container(
                        color: Colors.teal,
                        padding: EdgeInsets.all(10),
                        child: FutureBuilder<List<QueryDocumentSnapshot>>(
                            future:
                                FirebaseServices().getCoursesByClubId(club.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text('${snapshot.data?.length}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                      Expanded(
                        child: Text('Training Courses',
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
                        child: StreamBuilder<QuerySnapshot>(
                            stream: club.reference
                                .collection('subscribers')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text('${snapshot.data?.docs.length}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                      Expanded(
                        child: Text('Subscribers',
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
