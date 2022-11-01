import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget body;

  const CustomDialog({
    required this.title,
    required this.body,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required Widget body,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext contex) {
          return CustomDialog(
            body: body,
            title: title,
          );
        });
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTitle(),
                body,
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTitle() {
    return AutoSizeText(
      title,
      textAlign: TextAlign.center,
      maxLines: 2,
      // style: TextStyles.HEADING_2
      //     .apply(color: AppColors.PRIMARY_COLOR, fontStyle: FontStyle.normal),
    );
  }
}
