import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class ClubsPage extends StatelessWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const PageTitle(
          title: 'Clubs',
          titleColor: kSecondaryColor,
        ),
        actions: const [AppBarBackButton()],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding,
          vertical: kDefaultVerticalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.9,
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultVerticalPadding * 0.5,
                    crossAxisSpacing: kDefaultHorizontalPadding * 0.5,
                  ),
                  itemCount: availableClubs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ClubCard(
                      onPressed: () {
                        // go to club courses Details
                        Navigator.pushNamed(
                          context,
                          '/courses',
                          arguments: {
                            'name': availableClubs[index]['name'],
                          },
                        );
                      },
                      image: availableClubs[index]['image'],
                      name: availableClubs[index]['name'],
                      id: availableClubs[index]['id'],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
