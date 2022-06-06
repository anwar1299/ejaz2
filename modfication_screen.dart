import 'package:flutter/material.dart';

class ModficationScreen extends StatelessWidget {
  ModficationScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(this.title,
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
                        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909__340.png',
                        width: 110,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Saja Alharbi",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                      const Text(
                        "050XXXXXX",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        "10255214125",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
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
              title: const Text('Change image'),
              onTap: () {},
              onLongPress: () {},
            ),
            const Divider(
              height: 2,
              color: Colors.white,
            ),
            ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
              title: const Text(
                'Change phone number',
                style: TextStyle(color: Colors.white),
              ),

              //tileColor: Colors.white,
              onTap: () {},
              onLongPress: () {},
            ),
            const Divider(
              height: 2,
              color: Colors.white,
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: const Icon(Icons.lock),
              title: const Text('Change the password'),
              //tileColor: Colors.white,
              onTap: () {},
              onLongPress: () {},
            ),
            const Divider(
              height: 2,
              color: Colors.white,
            ),

            const Divider(
              height: 2,
              color: Colors.white,
            ),

            SizedBox(
              height: const Size.fromHeight(50).height,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: const StadiumBorder(),
                    primary: Colors.amberAccent,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 1.5, 48)),
                onPressed: () {},
                child: const Text(
                  'Save Chnages',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: const Size.fromHeight(50).height,
            ),
          ],
        ));
  }
}
