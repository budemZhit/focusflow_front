import 'package:flutter/material.dart';
import 'package:focus_flow/controller/get_mouth_with_number.dart';
import 'package:focus_flow/model/my_data.dart';

import 'arrow.dart';

class SelectedMouth extends StatelessWidget {
  final MyData selectedData;
  final Function onTapLeft;
  final Function onTapRight;

  const SelectedMouth({
    super.key,
    required this.selectedData,
    required this.onTapLeft,
    required this.onTapRight,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 70.0 ;
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LeftArrow(onTap: onTapLeft),
          Mouth(mouth: getMouthWithNumb(selectedData)),
          RightArrow(onTap: onTapRight),
        ],
      ),
    );
  }
}

class Mouth extends StatelessWidget {
  final String mouth;

  const Mouth({super.key, required this.mouth});

  @override
  Widget build(BuildContext context) {
    return Text(mouth, style: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ));
  }
}
