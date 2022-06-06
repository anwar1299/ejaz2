import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModficationClupScreen extends StatelessWidget {
  const ModficationClupScreen({Key? key, required this.club}) : super(key: key);
  final QueryDocumentSnapshot club;
  @override
  Widget build(BuildContext context) {
    // text controller
    final _nameController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text('Modfication',
              style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        club['image'],
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${club['name']}",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                      Text(
                        "${club['id']}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      FutureBuilder<DocumentSnapshot>(
                          future: FirebaseServices()
                              .getUserData(club['supervisor']),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                "${snapshot.data?.get('name')}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              );
                            } else {
                              return Text(
                                "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              );
                            }
                          }),
                    ],
                  )
                ],
              ),
            ),

            // 3 list tails
            const Divider(
              height: 2,
              color: Colors.white,
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: const Icon(Icons.add_photo_alternate_outlined),
              title: const Text('Change Club Image'),
              onTap: () {
                ImagePicker picker = ImagePicker();
                picker.pickImage(source: ImageSource.gallery).then((image) {
                  print('picked ${image}');
                  if (image != null) {
                    print(image.toString());
                    FirebaseServices().updateClubImage(image.path, club);
                  }
                });
              },
            ),
            const Divider(
              height: 2,
              color: Colors.white,
            ),
            ListTile(
              leading: const Icon(
                Icons.account_balance,
                color: Colors.white,
              ),
              title: const Text(
                'Change Club Name',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // update club name
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Change club name'),
                        content: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Club name',
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('Save'),
                            onPressed: () {
                              print(_nameController.text);
                              FirebaseServices()
                                  .updateClubName(club, _nameController.text);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            const Divider(
              height: 2,
              color: Colors.white,
            ),

            SizedBox(
              height: const Size.fromHeight(50).height,
            ),
          ],
        ));
  }
}
