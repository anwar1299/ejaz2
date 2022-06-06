import 'package:app/services/firebase_services.dart';
import 'package:app/ui/pages/club_profile_page.dart';
import 'package:app/ui/widgets/club_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.teal, fontSize: 20),
        title: const Text('My Clubs'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: FirebaseServices().getMyClubs(),
        builder:
            (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
          if (snapshot.hasData) {
            final clubs = snapshot.data;
            // check if there are no clubs
            if (clubs!.isEmpty) {
              return const Center(
                child: Text(
                  'No Clubs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: clubs.length,
              itemBuilder: (context, index) {
                final club = clubs[index];
                // check if key exists

                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClubCard(
                    id: club.get('description'),
                    name: club.get('name'),
                    image: club.get('image'),
                    onPressed: () {
                      final route = MaterialPageRoute(
                          builder: (context) => ClubProfilePage(
                                club: club,
                              ));
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
        },
      ),
    );
  }
}
