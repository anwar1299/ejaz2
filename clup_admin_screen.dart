import 'package:app/services/firebase_services.dart';
import 'package:app/ui/pages/profile_screen_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../add_new_club.dart';
import '../widgets/club_card.dart';
import 'admin_club_detail_page.dart';

class ClubAdminScreen extends StatelessWidget {
  const ClubAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.teal,
        floatingActionButton: FutureBuilder<bool>(
            future: FirebaseServices().isAdmin(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewClub()));
                    },
                    child: Icon(Icons.add),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
              // return FloatingActionButton(
              //   backgroundColor: Colors.amber,
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => AddNewClub()));
              //   },
              //   child: Icon(Icons.add),
              // );
            }),
        appBar: AppBar(
            titleTextStyle: const TextStyle(color: Colors.teal, fontSize: 20),
            title: const Text('Clubs'),
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.teal,
                  size: 30,
                ),
                onPressed: () {
                  //final route = MaterialPageRoute(
                      //builder: (context) => const ProfileScreenAdmin());
                //  Navigator.push(context, route);
                },
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseServices().clubs.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final clubs = snapshot.data?.docs;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: clubs?.length ?? 0,
                    // add space between cards

                    itemBuilder: (context, index) {
                      final club = clubs?.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClubCard(
                          name: club?.get('name'),
                          id: club!.get('description').toString(),
                          image: club.get('image'),
                          onPressed: () {
                            final route = MaterialPageRoute(
                                builder: (context) =>
                                    AdminClubDetailPage(club: club));
                            Navigator.push(context, route);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
