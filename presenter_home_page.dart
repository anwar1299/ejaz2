import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/fregments/home_appbar.dart';
import '../widgets/fregments/home_fragment.dart';
import '../widgets/fregments/profile_appbar.dart';
import '../widgets/fregments/profile_fragment.dart';
import '../widgets/fregments/search_appbar.dart';
import '../widgets/fregments/search_fragment.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageIndex == 0 ? kSecondaryColor : kPrimaryColor,
      bottomNavigationBar: CustomButtomNavigationBar(
        onTap: (index) {
          if (pageIndex != index) {
            setState(() {
              pageIndex = index;
            });
          }
        },
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: pageIndex == 0
            ? const HomeAppBar()
            : pageIndex == 1
                ? const SearchAppBar()
                : const ProfileAppBar(),
      ),
      body: Container(
        child: pageIndex == 0
            ? const HomeFragment()
            : pageIndex == 1
                ? const SearchFragment()
                : const ProfileFragment(),
      ),
    );
  }
}
