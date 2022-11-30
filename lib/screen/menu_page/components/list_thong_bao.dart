import 'package:flutter/material.dart';

class ListThongBao extends StatefulWidget {
  final List<dynamic> listValue;
  const ListThongBao({
    Key? key,
    required this.listValue,
  }) : super(key: key);

  @override
  State<ListThongBao> createState() => _ListThongBaoState();
}

class _ListThongBaoState extends State<ListThongBao> {
  List<String> listThongBao = [
    '未処理の入庫が 件あります。',
    '未処理の完了報告が 件あります。',
    '未処理の下見が 件あります。',
    '未処理の部材発注申請が 件あります。',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color(0xFFD9D9D9),
      ),
      child: Scrollbar(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.separated(
            itemCount: listThongBao.length,
            itemBuilder: (context, index) {
              return Text(
                listThongBao[index].split(" ")[0] +
                    " " +
                    widget.listValue[index] +
                    " " +
                    listThongBao[index].split(" ")[1],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF042C5C),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 5,
            ),
          ),
        ),
      ),
    );
  }
}
