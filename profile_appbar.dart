import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../page_title.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kSecondaryColor,
      centerTitle: true,
      title: const PageTitle(title: 'Profile'),
      leading: IconButton(
        onPressed: () {
          // go to notifications screen
          Navigator.pushNamed(context, '/notifications');
        },
        splashRadius: 20,
        icon: const Icon(
          Icons.notifications_none_rounded,
          color: kPrimaryColor,
          size: 30,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Go to modification page
            Navigator.pushNamed(context, '/modification');
          },
          splashRadius: 20,
          icon: const Icon(
            Icons.edit_rounded,
            color: kPrimaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
