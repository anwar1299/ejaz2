import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class StepProgressView extends StatelessWidget {
  final double _width;
  final List<String> _steps;
  final List<String>? _titles;
  final List<int>? failedStages;
  final int _curStep;
  final Color _activeColor;
  final Color? _titleColor;
  final Color? _inactiveColor = Colors.grey[100];
  final double lineWidth = 4.0;
  final double? iconSize;
  StepProgressView({
    Key? key,
    required List<String> steps,
    required int curStep,
    List<String>? titles,
    required double width,
    required Color color,
    this.iconSize,
    this.failedStages,
    Color? titleColor,
  })  : _steps = steps,
        _titles = titles,
        _curStep = curStep,
        _titleColor = titleColor,
        _width = width,
        _activeColor = color,
        assert(curStep > 0 == true && curStep <= steps.length),
        assert(width > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: _iconViews(),
          ),
          const SizedBox(
            height: 10,
          ),
          if (_titles != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _titleViews(),
            ),
        ],
      ),
    );
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    _titles!.asMap().forEach((i, text) {
      list.add(
        Text(
          text,
          style: TextStyle(
            color: _titleColor ?? Colors.white,
            fontSize: kStepperFontSize,
          ),
        ),
      );
    });
    return list;
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    _steps.asMap().forEach((i, icon) {
      //colors according to state
      Color? circleColor;
      Color? lineColor;
      if (failedStages != null) {
        circleColor = (failedStages!.contains(i + 1))
            ? Colors.red
            : (i == 0 || _curStep > i + 1)
                ? _activeColor
                : _inactiveColor;
        lineColor = (failedStages!.contains(i + 2))
            ? Colors.red
            : (i == 0 || _curStep > i + 2)
                ? _activeColor
                : _inactiveColor;
      } else {
        circleColor =
            (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;
        lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;
      }

      list.add(
        //dot with icon view
        Container(
          width: iconSize ?? 25.0,
          height: iconSize ?? 25.0,
          padding: const EdgeInsets.all(0),
          alignment: AlignmentDirectional.center,
          child:
              // Icon(
              //   icon,
              //   color: iconColor,
              //   size: iconSize != null ? iconSize! - 5 : 20.0,
              // ),
              Text(
            icon,
          ),
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
              color: circleColor!,
              width: 2.0,
            ),
          ),
        ),
      );

      //line between icons
      if (i != _steps.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    });

    return list;
  }
}
