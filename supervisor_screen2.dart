import 'package:app/model/user.dart';
import 'package:app/services/firebase_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SupervisorScreen2 extends StatelessWidget {
  const SupervisorScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: const Text('Supervisor',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        body: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: FirebaseServices().getSupervisor(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final clubs = snapshot.data;
              // create a list of UserData
              List<UserData>? userData = clubs?.map((club) {
                return UserData.fromJson(club.data() as Map<String, dynamic>);
              }).toList();
              // check if empty
              if (clubs!.isEmpty) {
                return Center(
                  child: Text('No Supervisor yet'),
                );
              }
              return ListView.builder(
                itemCount: userData!.length,
                itemBuilder: (context, index) {
                  final user = userData[index];
                  return Card(
                    elevation: 10,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.teal,
                        backgroundImage:
                            CachedNetworkImageProvider(user.image ?? ''),
                      ),
                      title: Text(
                        user.name ?? '',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      subtitle: Text(
                        user.email ?? '',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon: user.isActive!
                            ? Icon(Icons.delete)
                            : Icon(Icons.check),
                        onPressed: () {
                          if (user.isActive == null) {
                            FirebaseServices().acceptSupervisor(clubs[index]);
                          } else if (user.isActive == true) {
                            FirebaseServices().deleteSupervisor(clubs[index]);
                          } else if (user.isActive == false) {
                            FirebaseServices().acceptSupervisor(clubs[index]);
                          }
                        },
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AdminClubScreen(club: clubs[index]),
                        //   ),
                        // );
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
