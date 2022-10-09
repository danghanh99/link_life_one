import 'package:flutter/material.dart';
import 'package:link_life_one/shared/text_style.dart';

class CustomButton extends StatelessWidget {
  final Function onClick;
  final Color? color;
  final TextStyle? textStyle;
  final String? name;
  final double? borderRadius;
  CustomButton({
    Key? key,
    required this.onClick,
    this.color = Colors.purple,
    this.textStyle,
    this.name,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name2 = name ?? '';
    final arr = name2.split(' ');
    if (arr.length >= 2) {
      final arr = name!.split(' ');
      return Container(
        decoration: BoxDecoration(
          color: color ?? Colors.purple,
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
        child: Center(
          child: TextButton(
            onPressed: () {
              // onClick.call();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  arr[0],
                  style: textStyle ??
                      TextStyles.BODY_14.apply(
                        color: Colors.white,
                      ),
                ),
                Text(
                  arr[1],
                  style: textStyle ??
                      TextStyles.BODY_14.apply(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.purple,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
      ),
      child: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onClick.call();
          },
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
        ),
      ),
    );
  }
}
