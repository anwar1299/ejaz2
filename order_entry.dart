import 'package:app/ui/widgets/step_progress_view.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class OrderEntry extends StatelessWidget {
  OrderEntry({
    Key? key,
    required this.index,
    required this.orderCurrentStage,
    this.failedStages,
    required this.onPressed,
  }) : super(key: key);
  final int index;
  final int orderCurrentStage;
  final List<int>? failedStages;
  final Function() onPressed;

  final List<String> stageTitles = [
    'request',
    'review',
    'approval',
    'reject',
    'end',
  ];
  final List<String> steps = ['1', '2', '3', '4', '5'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenHeight(context) * 0.1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: kSecondaryColor)),
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: kCourseTitleFontSize,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(top: kDefaultVerticalPadding * 0.5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: kSecondaryColor),
                  right: BorderSide(color: kSecondaryColor),
                  left: BorderSide(color: kSecondaryColor),
                ),
              ),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: StepProgressView(
                  steps: steps,
                  titles: stageTitles,
                  failedStages: failedStages,
                  iconSize: 25,
                  curStep: orderCurrentStage,
                  width: getScreenWidth(context) * 0.7,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: kSecondaryColor)),
              ),
              child: Center(
                child: orderCurrentStage > 3 || failedStages!.contains(4)
                    ? IconButton(
                        onPressed: onPressed,
                        icon: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: kSecondaryColor,
                          size: kDefaultIconSize,
                        ),
                        splashRadius: 20,
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
