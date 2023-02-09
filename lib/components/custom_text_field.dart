import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../shared/colors.dart';
import '../shared/date_formatter.dart';
import '../shared/text_style.dart';

class CustomTextField extends StatefulWidget {
  final Key? keyMessage;
  final String? hint;
  final Color? textColor;
  final Color? fillColor;
  final TextInputType type;
  final TextAlign align;
  final bool isPassword;
  final bool isDatePicker;
  final bool onCopy;
  final int maxLines;
  final FocusNode? ownFocus;
  final FocusNode? nextFocus;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  final Color eyeButtonColor;
  final Function(DateTime)? onDatePicked;
  final bool? isChatText;
  final Function? onTap;
  final int? maxLength;
  final bool? isNameField;
  final bool? largeHint;
  final TextInputAction? textInputAction;
  final bool isReadOnly;
  final bool showCursor;
  final DateTime? initialDate;
  final String? initValue;
  final Color? borderColor;
  const CustomTextField({
    this.borderColor,
    this.initialDate,
    this.initValue,
    this.hint,
    required this.type,
    this.keyMessage,
    this.isReadOnly = false,
    this.largeHint,
    this.textColor,
    this.fillColor = Colors.white,
    this.isPassword = false,
    this.isDatePicker = false,
    this.showCursor = true,
    this.maxLines = 1,
    this.align = TextAlign.start,
    this.textCapitalization = TextCapitalization.sentences,
    this.ownFocus,
    this.nextFocus,
    this.validator,
    this.controller,
    this.inputFormatters,
    this.onChanged,
    this.onCopy = false,
    this.eyeButtonColor = AppColors.GREY,
    this.isChatText,
    this.onDatePicked,
    this.onTap,
    this.maxLength,
    this.isNameField = false,
    this.textInputAction,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

bool colorIcon = false;

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    if (widget.isDatePicker) dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initValue,
      key: widget.keyMessage,
      onTap: () async {
        widget.onTap?.call();
        if (widget.isDatePicker) {
          _pickDate();
        }
      },
      showCursor: widget.showCursor ? true : false,
      cursorColor: Colors.black,
      autocorrect: true,
      maxLength: widget.maxLength,
      readOnly: widget.isReadOnly ? true : (widget.isDatePicker ? true : false),
      toolbarOptions: ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      maxLines: widget.maxLines,
      controller: widget.controller,
      obscureText: widget.isPassword && !showPassword,
      style: widget.largeHint == true
          ? TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
              fontFamily: 'LinotteSemiBold',
              fontSize: 18,
            )
          : TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
              fontFamily: 'LinotteSemiBold',
            ),
      keyboardType: widget.type,
      textAlign: widget.align,
      focusNode: widget.ownFocus,
      textInputAction: widget.isChatText == true
          ? widget.textInputAction
          : (widget.nextFocus != null)
              ? TextInputAction.next
              : TextInputAction.done,
      validator: widget.validator,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: (v) =>
          FocusScope.of(context).requestFocus(widget.nextFocus),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        counterText: '',
        errorStyle: TextStyles.BODY_14.apply(
          color: AppColors.ERROR_VALIDATE,
          fontFamily: 'LinotteSemiBold',
        ),
        isDense: true,
        helperText: '',
        filled: true,
        errorMaxLines: 2,
        enabledBorder: _borderOutline(),
        focusedBorder: _borderOutline(),
        errorBorder: _borderOutline(),
        border: _borderOutline(),
        fillColor: widget.fillColor,
        disabledBorder: _borderOutline(),
        focusedErrorBorder: _borderOutline(),
        hintText: widget.hint,
        hintStyle: widget.largeHint == null
            ? TextStyles.BODY_14.apply(
                color: AppColors.PLACE_HOLDER,
                fontFamily: 'LinotteSemiBold',
              )
            : TextStyles.BODY_18.apply(
                color: AppColors.PLACE_HOLDER,
                fontFamily: 'LinotteSemiBold',
              ),
        contentPadding: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
      ),
    );
  }

  Widget? _buildIcon() {
    if (widget.isDatePicker) {
      return _buildIconDatePicker();
    } else if (widget.isPassword) {
      return IconButton(
        onPressed: _togglePassword,
        icon: Icon(
          showPassword ? Icons.visibility : Icons.visibility_off,
          color: widget.eyeButtonColor,
        ),
      );
    } else if (widget.onCopy) {
      return IconButton(
        icon: Icon(
          Icons.copy,
          color: colorIcon ? Colors.blue : Colors.black54,
        ),
        onPressed: () {
          setState(() {
            _copyCode();
            colorIcon = !colorIcon;
          });
        },
      );
    } else
      return null;
  }

  Widget _buildIconDatePicker() {
    return IconButton(
      onPressed: () {
        _pickDate();
      },
      icon: Icon(Icons.date_range),
    );
  }

  Widget toast = Container(
    // padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
    ),
    child: Text('Copied'),
  );

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryTextColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: AppColors.primaryTextColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: AppColors.primaryTextColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: widget.initialDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now()); // DateTime(Constants.maxBirthYear));

    if (pickedDate != null) {
      widget.onDatePicked?.call(pickedDate);
      print(pickedDate);
      // String formattedDate = DateFormat(DateFormats.dayMonthYear).format(pickedDate);

      setState(() {
        dateinput.text = "formattedDate";
      });
    }
  }

  void _copyCode() {}

  void _togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  OutlineInputBorder _borderOutline() => OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(0)),
        borderSide:
            BorderSide(color: widget.borderColor ?? AppColors.BORDER, width: 1),
      );
}
