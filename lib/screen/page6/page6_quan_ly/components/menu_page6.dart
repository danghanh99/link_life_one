import 'package:flutter/material.dart';
import 'package:link_life_one/api/order/saibuhacchu_ichiran/get_part_order_list_ichiran.dart';

import '../../../menu_page/components/custom_menu_button.dart';

class MenuPage6 extends StatefulWidget {
  final List<String> listNames;
  const MenuPage6({
    required this.listNames,
    Key? key,
  }) : super(key: key);

  @override
  State<MenuPage6> createState() => _MenuPage6State();
}

class _MenuPage6State extends State<MenuPage6> {

  bool? isShowMenu63;

  @override
  void initState() {
    super.initState();
    _checkBuzaiHacokFlg();
  }

  _checkBuzaiHacokFlg() async {
    isShowMenu63 = !await GetPartOrderListIchiran().checkBuzaiHacokFlg(
        onSuccess: (){},
        onFailed: (){}
    );
    setState(() {});
  }

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
            Visibility(
              visible: isShowMenu63 ?? false,
              child: CustomMenuButton(
                width: 300,
                height: 70,
                name: widget.listNames[2],
              ),
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
