import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubscribesScreen extends StatelessWidget {
  const SubscribesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get data from thhe arguments
    final QueryDocumentSnapshot club =
        ModalRoute.of(context)?.settings.arguments as QueryDocumentSnapshot;
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text(
            'Subscribes',
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: club.reference.collection('subscribers').snapshots(),
            builder: (context, snapshot) {
              print('We are here');
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final List<DocumentSnapshot> documents =
                  snapshot.data?.docs ?? const [];
              print('We are here ${documents.length}');
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    if (snapshot.hasData) {
                      final DocumentSnapshot document = documents[index];

                      // get user data by id
                      return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseServices()
                              .getUserData(document.get('userId') as String),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error ${snapshot.error}'),
                              );
                            }
                            final user = snapshot.data;

                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text(user?.get('name') as String),
                                subtitle: Text(user?.get('email') as String),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error ${snapshot.error}'),
                      );
                    } else
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  });
            }));
  }
}
