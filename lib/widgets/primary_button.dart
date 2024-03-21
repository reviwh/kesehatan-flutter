import 'package:flutter/material.dart';
import 'package:kesehatan/theme/theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Color buttonColor;
  final String textValue;
  final Color textColor;
  final bool enabled;
  final Function() onTap;

  const CustomPrimaryButton({
    super.key,
    this.buttonColor = Colors.black,
    this.textValue = '',
    this.textColor = Colors.black,
    this.enabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      elevation: 0,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(14)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : () {},
            borderRadius: BorderRadius.circular(14),
            child: Center(
              child: Text(
                textValue,
                style: heading5.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
