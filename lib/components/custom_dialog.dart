import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog {
  static void showCustomDialog(
      BuildContext context,
      String title,
      String message,
      String cancelTitle,
      String okTitle,
      Function() onCancel,
      Function() onOK) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SizedBox(
          width: double.infinity,
          child: CupertinoAlertDialog(
            title: Text(
              title,
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                message,
                style: const TextStyle(
                  color: Color.fromARGB(255, 24, 23, 23),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    onCancel();
                  },
                  child: Text(
                    cancelTitle,
                    style: const TextStyle(
                      color: Color(0xFFEB5757),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  onOK();
                },
                child: Text(
                  okTitle,
                  style: const TextStyle(
                    color: Color(0xFF007AFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}