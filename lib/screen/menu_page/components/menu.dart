import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_menu_button.dart';

class Menu extends StatefulWidget {
  final List<String> listNames;
  const Menu({
    required this.listNames,
    Key? key,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomMenuButton(
              width: 300.w,
              height: 70.h,
              name: widget.listNames[0],
            ),
            const SizedBox(
              width: 40,
            ),
            CustomMenuButton(
              width: 300.w,
              height: 70.h,
              name: widget.listNames[1],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomMenuButton(
              width: 300.w,
              height: 70.h,
              name: widget.listNames[2],
            ),
            const SizedBox(
              width: 40,
            ),
            CustomMenuButton(
              width: 300.w,
              height: 70.h,
              name: widget.listNames[3],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomMenuButton(
              width: 300.w,
              height: 70.h,
              name: widget.listNames[4],
            ),
            const SizedBox(
              width: 40,
            ),
            CustomMenuButton(
              width: 300.w,
              height: 70.h,
              name: widget.listNames[5],
            ),
          ],
        ),
      ],
    );
  }
}
