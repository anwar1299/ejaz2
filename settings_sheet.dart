import 'package:app/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({
    Key? key,
    required this.onOptionPressed,
  }) : super(key: key);
  final Function(int) onOptionPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(context) * 0.5,
      width: getScreenWidth(context),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultHorizontalPadding,
        vertical: kDefaultVerticalPadding * 0.5,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: kDefaultHorizontalPadding * 1.5),
                const PageTitle(
                  title: 'Settings',
                  titleColor: kSecondaryColor,
                ),
                IconButton(
                  onPressed: () {
                    // Close sheet
                    Navigator.pop(context);
                  },
                  splashRadius: 25,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: kSecondaryColor,
                    size: kDefaultIconSize,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: kDefaultVerticalPadding),
          Expanded(
            flex: 4,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: settingOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      onTap: () {
                        onOptionPressed(index);
                      },
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: kDefaultHorizontalPadding,
                      ),
                      leading: Icon(
                        settingOptions[index]['icon'],
                        color: kSecondaryColor,
                      ),
                      title: Text(
                        settingOptions[index]['title'],
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: kTextFontSize,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                      height: 0.05,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
