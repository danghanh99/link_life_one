import 'package:flutter/material.dart';

import '../../../menu_page/components/custom_menu_button.dart';

class MenuPage5 extends StatefulWidget {
  final List<String> listNames;
  const MenuPage5({
    required this.listNames,
    Key? key,
  }) : super(key: key);

  @override
  State<MenuPage5> createState() => _MenuPage5State();
}

class _MenuPage5State extends State<MenuPage5> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomMenuButton(
              width: 300,
              height: 70,
              name: widget.listNames[0],
            ),
            const SizedBox(
              width: 40,
            ),
            CustomMenuButton(
              width: 300,
              height: 70,
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
              width: 300,
              height: 70,
              name: widget.listNames[2],
            ),
            const SizedBox(
              width: 40,
            ),
            const SizedBox(
              width: 300,
              height: 70,
            ),
          ],
        ),
      ],
    );
  }
}
