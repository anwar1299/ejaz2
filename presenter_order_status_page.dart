import 'package:app/main.dart';
import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        backgroundColor: kPrimaryColor,
        title: const PageTitle(
          title: 'Order Status',
          titleColor: kSecondaryColor,
        ),
        elevation: 0,
        actions: const [
          AppBarBackButton(),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: getScreenHeight(context) * 0.05),
          Expanded(
            child: FutureBuilder<List<QueryDocumentSnapshot>>(
                future: FirebaseServices()
                    .getCoursesByUserId(auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final courses = snapshot.data;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courses!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final course = courses[index];
                        // check status
                        final status = course['state'];
                        var ordersList = 1;
                        var failedStages = <int>[];
                        if (status == 1 ||
                            status == 2 ||
                            status == 3 ||
                            status == 4) {
                          ordersList = status;
                          failedStages = <int>[];
                        } else {
                          ordersList = 3;
                          failedStages = <int>[4, 5];
                        }
                        return OrderEntry(
                          index: index + 1,
                          orderCurrentStage: ordersList,
                          failedStages: failedStages,
                          onPressed: () {
                            _showNoteSheet(context, ordersList);
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: kSecondaryColor),
                      right: BorderSide(color: kSecondaryColor),
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          )
        ],
      ),
    );
  }
}

void _showNoteSheet(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    backgroundColor: kPrimaryColor,
    elevation: 1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (context) {
      String message = 'Approved, we wish you success';
      String btnLabel = 'Confirmation';

      switch (index) {
        case 1:
          message = 'We apologize: the room was refused\ndue to unavailability';
          btnLabel = 'Reorder';
          break;
        case 3:
          message =
              'The training course has\nbeencompleted, thank\nyou for that';
          btnLabel = 'Report';
          break;
        default:
          message = 'Approved, we wish you success';
          btnLabel = 'Confirmation';
      }
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
                    title: 'Note',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: kTextFontSize,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      switch (index) {
                        case 1:
                          int count = 0;
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/request',
                            (route) => count++ >= 2,
                          );
                          break;
                        case 2:
                          Navigator.pop(context);
                          break;
                        case 3:
                          int count = 0;
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/rating',
                            (route) => count++ >= 2,
                          );
                          break;
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: kAccentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultHorizontalPadding * 2.0,
                        vertical: kDefaultVerticalPadding * 0.25,
                      ),
                      child: Text(
                        btnLabel,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: kTitlesFontSize,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
