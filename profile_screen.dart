import 'package:app/main.dart';
import 'package:app/ui/pages/profile_screen_admin.dart';
import 'package:flutter/material.dart';

import '../../add_cours_screen.dart';
import 'Modfication_Supr_Screen.dart';
import 'clubs_screen.dart';
import 'login_Screen.dart';
import 'notfication_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
            titleTextStyle: const TextStyle(color: Colors.teal, fontSize: 16),
            title: const Text("Profile"),
            leading: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.teal,
                  size: 30,
                ),
                onPressed: () {
                  final route = MaterialPageRoute(
                      builder: (context) => ModficationsSuprScreen());
                  Navigator.push(context, route);
                }),
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons
                        .add_alert_outlined, //Padding(padding:EdgeInsets.only(left: 80),//),
                    color: Colors.teal,
                    size: 30,
                  ),
                  onPressed: () {
                    final route = MaterialPageRoute(
                        builder: (context) => NotificationScreen());
                    Navigator.push(context, route);
                  }),
            ]),
        body: Column(children: [
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
              const Text('anwar',
                  style: TextStyle(color: Colors.teal, fontSize: 15)),
              const Text('phone number',
                  style: TextStyle(color: Colors.teal, fontSize: 15)),
              const Text('ID number',
                  style: TextStyle(color: Colors.teal, fontSize: 15)),

              const Padding(padding: EdgeInsets.only(top: 50.0)),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.account_balance_rounded),
                  title: const Text('clubs'),
                  onTap: () {
                    final route =
                        MaterialPageRoute(builder: (context) => ClubsScreen());
                    Navigator.push(context, route);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    dialog(context);
                  },
                ),
              ),

              // InkWell( child:
              Card(
                  child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  auth.signOut().then((value) {
                    final route =
                        MaterialPageRoute(builder: (context) => LoginScreen());
                    Navigator.pushReplacement(context, route);
                  });
                },
              )),
              const SizedBox(
                height: 60,
              ),
            ]),
          ),
        ]));
  }

  void dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.close_sharp,
                    color: Colors.teal,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
            title: const Text('Settings'),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              //ListView(
              //children: [
              ListTile(
                leading: const Icon(Icons.add_alert),
                title: const Text('notifications'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.language_rounded),
                title: const Text('language'),
                onTap: () {
                  final route =
                      MaterialPageRoute(builder: (context) => AddCoursScreen());
                  Navigator.push(context, route);
                },
              ),
              ListTile(
                leading: const Icon(Icons.call),
                title: const Text('Help'),
                onTap: () {
                  final route = MaterialPageRoute(
                      builder: (context) => ProfileScreenAdmin());
                  Navigator.push(context, route);
                },
              ),
            ]),
          );
        });
  }
}
