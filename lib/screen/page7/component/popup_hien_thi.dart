import 'package:flutter/material.dart';

class PopupHienThi extends StatefulWidget {
  final dynamic body;
  final String month;
  const PopupHienThi({
    required this.body,
    required this.month,
    Key? key,
  }) : super(key: key);

  @override
  State<PopupHienThi> createState() => _PopupHienThiState();
}

class _PopupHienThiState extends State<PopupHienThi> {
  String tongNgayNghiCuaNam = "0";
  String soNgayDaNghiTrongNam = "0";
  String soNgayNghiConLaiTrongNam = "0";

  String tongNgayNghiCuaThang = "0";
  String soNgayDaNghiTrongThang = "0";
  String soNgayNghiConLaiTrongThang = "0";
  String soNgayNghiVuotQuaTrongThang = "0";

  @override
  void initState() {
    if(widget.body.runtimeType==List && (widget.body as List).isEmpty){

    }
    else{
      tongNgayNghiCuaNam = widget.body['YEAR']?['AVAILABLE_DAYS'] ?? '';
      soNgayDaNghiTrongNam = widget.body['YEAR']?['DAY_OFFS'] ?? '';
      soNgayNghiConLaiTrongNam = widget.body['YEAR']?['THE_REST_OF_DAY_OFFS'] ?? '';

      tongNgayNghiCuaThang = widget.body['MONTH']?['AVAILABLE_DAYS'] ?? '';
      soNgayDaNghiTrongThang = widget.body['MONTH']?['DAY_OFFS'] ?? '';
      soNgayNghiConLaiTrongThang = widget.body['MONTH']?['THE_REST_OF_DAY_OFFS'] ?? '';
      soNgayNghiVuotQuaTrongThang = widget.body['MONTH']?['DAY_OFFS_OVER'] ?? '';
    }
    super.initState();
  }

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
                        textVsBoxText(
                            '可能日数', tongNgayNghiCuaThang, Colors.black),
                        textVsBoxText(
                            '既取得日数', soNgayDaNghiTrongThang, Colors.black),
                        textVsBoxText(
                            '残日数', soNgayNghiConLaiTrongThang, Colors.red),
                        textVsBoxText(
                            '過剰取得日数',
                            soNgayNghiVuotQuaTrongThang,
                            int.parse(soNgayNghiVuotQuaTrongThang) > 0
                                ? Colors.red
                                : Colors.black),
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
                        textVsBoxText('年間休日', tongNgayNghiCuaNam, Colors.black),
                        textVsBoxText(
                            '取得済日数', soNgayDaNghiTrongNam, Colors.black),
                        textVsBoxText(
                            'あと', soNgayNghiConLaiTrongNam, Colors.red),
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
