import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../page_title.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      elevation: 0,
      title: const PageTitle(
        title: 'Search',
        titleColor: kSecondaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
