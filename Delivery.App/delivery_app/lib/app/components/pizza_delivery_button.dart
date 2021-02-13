import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PizzaDeliveryButton extends StatelessWidget {
  final double width;
  final double height;
  final Color buttomColor;
  final String label;
  final TextStyle textStyle;
  final Color labelColor;
  final double labelSize;
  final Function onPressed;

  const PizzaDeliveryButton({
    Key key,
    this.width,
    this.height,
    this.buttomColor,
    this.label,
    this.textStyle,
    this.labelColor,
    this.labelSize,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.width,
      height: this.height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: this.onPressed,
        color: this.buttomColor,
        child: Text(
          this.label,
          style: this.textStyle ??
              TextStyle(fontSize: this.labelSize, color: this.labelColor),
        ),
      ),
    );
  }
}
