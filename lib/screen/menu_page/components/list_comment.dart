import 'package:flutter/material.dart';

class ListComment extends StatefulWidget {
  const ListComment({
    Key? key,
  }) : super(key: key);

  @override
  State<ListComment> createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  List<String> listComments = [
    '2022 / 11 / 11　工事のテスト様に新着コメントがあります。',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
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
            itemCount: listComments.length,
            itemBuilder: (context, index) {
              return Text(
                listComments[index],
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
