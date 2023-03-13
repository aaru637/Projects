import 'package:flutter/material.dart';

class Follow_Button extends StatefulWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  const Follow_Button(
      {Key? key,
      this.function,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.textColor})
      : super(key: key);

  @override
  State<Follow_Button> createState() => _Follow_ButtonState();
}

class _Follow_ButtonState extends State<Follow_Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: TextButton(
        onPressed: widget.function,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: Border.all(
              color: widget.borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: 210,
          child: Text(
            widget.text,
            style:
                TextStyle(color: widget.textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
