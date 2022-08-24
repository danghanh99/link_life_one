import 'package:flutter/material.dart';
import 'package:link_life_one/shared/text_style.dart';

class CustomButton extends StatelessWidget {
  final Function onClick;
  final Color? color;
  final TextStyle? textStyle;
  final String? name;
  CustomButton({
    Key? key,
    required this.onClick,
    this.color = Colors.purple,
    this.textStyle,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.purple,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () {
          onClick.call();
        },
        child: Text(
          name ?? 'Save',
          style: textStyle ??
              TextStyles.BODY_14.apply(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
