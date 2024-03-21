import 'package:flutter/material.dart';
import 'package:kesehatan/theme/theme.dart';

class CustomDialogButton extends StatelessWidget {
  final Color buttonColor;
  final String textValue;
  final Color textColor;
  final bool enabled;
  final double width;
  final Function() onTap;

  const CustomDialogButton({
    super.key,
    this.buttonColor = Colors.black,
    this.textValue = '',
    this.textColor = Colors.white,
    this.enabled = true,
    this.width = 84,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: enabled ? onTap : () {},
        child: Container(
          height: 32,
          alignment: Alignment.center,
          width: width,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            textValue,
            style: heading5.copyWith(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
