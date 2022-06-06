import 'package:app/ui/pages/supervisor_screen2.dart';
import 'package:flutter/material.dart';

import 'clup_admin_screen.dart';
import 'login_Screen.dart';
import 'modfication_screen.dart';
import 'notfication_screen.dart';

class ProfileScreenAdmin extends StatelessWidget {
  const ProfileScreenAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
            titleTextStyle: TextStyle(color: Colors.teal, fontSize: 16),
            title: Text("Profile"),
            leading: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.teal,
                  size: 30,
                ),
                onPressed: () {
                  final route = MaterialPageRoute(
                      builder: (context) => ModficationScreen(
                            title: '',
                          ));
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
              const Text('saja',
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
                    final route = MaterialPageRoute(
                        builder: (context) => ClubAdminScreen());
                    Navigator.push(context, route);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('supervisor'),
                  onTap: () {
                    final route = MaterialPageRoute(
                        builder: (context) => SupervisorScreen2());
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
                  final route =
                      MaterialPageRoute(builder: (context) => LoginScreen());
                  Navigator.push(context, route);
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
                onTap: () {},
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
