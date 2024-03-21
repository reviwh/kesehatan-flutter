import 'package:flutter/material.dart';
import 'package:kesehatan/theme/theme.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: isChecked ? primary : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: isChecked ? null : Border.all(color: textGrey, width: 1.5)),
        width: 20,
        height: 20,
        child: isChecked
            ? const Icon(
                Icons.check_rounded,
                size: 20,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
