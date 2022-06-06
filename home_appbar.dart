import 'package:app/main.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kSecondaryColor,
      leading: IconButton(
        icon: const Icon(
          Icons.notifications_outlined,
          size: kDefaultIconSize,
          color: kPrimaryColor,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/notifications');
        },
        splashRadius: 20,
      ),
      actions: [
        // singout button
        IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            size: kDefaultIconSize,
            color: kPrimaryColor,
          ),
          onPressed: () {
            // firsbase singout
            // then navigate to login page
            auth.signOut().then((value) {
              Navigator.pushNamed(context, '/login');
            });
          },
          splashRadius: 20,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
