import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  const CustomButtomNavigationBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function(int) onTap;

  @override
  State<CustomButtomNavigationBar> createState() =>
      _CustomButtomNavigationBarState();
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        // Make transition
        setState(() {
          selectedIndex = index;
        });
        widget.onTap(index);
      },
      currentIndex: selectedIndex,
      iconSize: 30,
      items: const [
        // Home Page
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.home,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.home,
            color: kPrimaryColor,
          ),
        ),

        // Search Page
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.search_rounded,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.search_rounded,
            color: kPrimaryColor,
          ),
        ),

        // Profile Page
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.person_rounded,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.person_rounded,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
