import 'package:app/ui/pages/supervisor_club_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/option_listtile.dart';
import 'approve_course_page.dart';
import 'modfication_clup_screen.dart';

class ClubProfilePage extends StatelessWidget {
  const ClubProfilePage({Key? key, required this.club}) : super(key: key);
  final QueryDocumentSnapshot club;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          titleTextStyle: TextStyle(color: Colors.teal, fontSize: 16),
          title: Text("Club Profile"),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                //Padding(padding:EdgeInsets.only(left: 80),//),
                color: Colors.teal,
                size: 30,
              ),
              onPressed: () {
                // go back
                Navigator.pop(context);
              }),
        ),
        body: Column(children: [
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
                            "https://www.pngitem.com/pimgs/m/9-948894_no-image-available-icon-png-transparent.png")))),
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            // children: <Widget>[
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Text(club['name'],
                  style: TextStyle(color: Colors.teal, fontSize: 15)),
              Text(club['description'],
                  style: TextStyle(color: Colors.teal, fontSize: 15)),

              const Padding(padding: EdgeInsets.only(top: 50.0)),

              OptionListTile(
                icon: Icons.person_rounded,
                title: ('Supervisor'),
                onPressed: () {
                  final route = MaterialPageRoute(
                      builder: (context) => SupervisorClupScreen(
                            supervisorId: club['supervisor'],
                          ));
                  Navigator.push(context, route);
                },
              ),
              OptionListTile(
                icon: Icons.people_rounded,
                title: ('Subscribers'),
                onPressed: () {
                  Navigator.pushNamed(context, '/club_subscribers',
                      arguments: club);
                },
              ),

              // InkWell( child:
              OptionListTile(
                icon: (Icons.menu_book_sharp),
                title: ('Training courses'),
                onPressed: () {
                  // push name club_courses
                  Navigator.pushNamed(context, '/club_courses',
                      arguments: club.id);
                },
              ),
              OptionListTile(
                icon: (Icons.settings),
                title: ('Training Requests'),
                onPressed: () {
                  final route = MaterialPageRoute(
                      builder: (context) => ApproveCoursePage(clubId: club.id));
                  Navigator.push(context, route);
                },
              ),
              OptionListTile(
                icon: (Icons.edit),
                title: ('Modification'),
                onPressed: () {
                  final route = MaterialPageRoute(
                      builder: (context) => ModficationClupScreen(
                            club: club,
                          ));
                  Navigator.push(context, route);
                },
              ),
              const SizedBox(
                height: 60,
              ),
            ]),
          ),
        ]));
  }
}
