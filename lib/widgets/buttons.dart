import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  Buttons({this.color, this.textColor, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: buttonTapped ,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            // width: MediaQuery.of(context).size.width * 1.08,
            // height: MediaQuery.of(context).size.height * 0.08,
            color: color,
            child: Center(
              child: Text(buttonText, style: TextStyle(color: textColor, fontSize: 20)),
            ),
          ),
        ),
      ),
    );
  }
}
