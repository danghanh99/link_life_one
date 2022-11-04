import 'package:flutter/material.dart';

class PopupHienThi extends StatefulWidget {
  const PopupHienThi({
    Key? key,
  }) : super(key: key);

  @override
  State<PopupHienThi> createState() => _PopupHienThiState();
}

class _PopupHienThiState extends State<PopupHienThi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height: 400,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red, border: Border.all(color: Colors.red)),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 16,
                  top: 8,
                  bottom: 8,
                ),
                child: Container(
                  height: 320,
                  width: 250,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      labelText: '当日の休日取得',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                    ),
                    child: Column(
                      children: [
                        textVsBoxText('可能日数', '7', Colors.black),
                        textVsBoxText('既取得日数', '3', Colors.black),
                        textVsBoxText('残日数', '4', Colors.red),
                        textVsBoxText('過剰取得日数', '0', Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 320,
                  width: 250,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      labelText: '',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                    ),
                    child: Column(
                      children: [
                        textVsBoxText('年間休日', '98', Colors.black),
                        textVsBoxText('取得済日数', '17', Colors.black),
                        textVsBoxText('あと', '81', Colors.red),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget textVsBoxText(String text1, String text2, Color color) {
    return Row(
      children: [
        Container(
          width: 110,
          child: Text(
            text1,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          width: 70,
          height: 40,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Text(
            text2,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
