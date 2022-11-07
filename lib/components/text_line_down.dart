import 'package:flutter/material.dart';

class TextLineDown extends StatefulWidget {
  final String text;
  final Function? onTap;
  const TextLineDown({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  State<TextLineDown> createState() => _TextLineDownState();
}

class _TextLineDownState extends State<TextLineDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFDFE0E3),
                width: 2.0,
              ),
            ),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                widget.onTap != null
                    ? widget.onTap!.call()
                    : Navigator.pop(context);
              },
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xFF042C5C),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
