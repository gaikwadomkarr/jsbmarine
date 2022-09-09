import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:sizer/sizer.dart';

import '../utils/color_constants.dart';
import 'common_views.dart';

class CTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? expands;
  final String? hint_text;
  final Color? color;
  final TextStyle? hintTextStyle;
  final String? initialValue;
  final String? lable_text;
  final String? suffix_text;
  final String? prefixWidget;
  final double? width;
  final dynamic? textfieldBorder;
  final IconData? icon;
  final String? suffixWidget;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final TextStyle? style;
  final bool? enabled;
  final bool? obscure;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validation;
  final ValueChanged<String>? onSaved;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int? maxline;
  final Function()? onPressed;
  final EdgeInsets? padding;
  final bool? readOnly;
  final int? maxLength;

  CTextField(
      {Key? key,
      this.controller,
      this.hint_text,
      this.initialValue,
      this.lable_text,
      this.suffix_text,
      this.icon,
      this.suffixWidget = null,
      this.textInputType,
      this.textInputAction,
      this.isPassword = false,
      this.style,
      this.enabled = true,
      this.inputFormatters,
      this.validation,
      this.onSaved,
      this.focusNode,
      this.nextFocusNode,
      this.maxline = 1,
      this.onPressed,
      this.readOnly = false,
      this.maxLength,
      this.width,
      this.expands = false,
      this.textfieldBorder,
      this.hintTextStyle,
      this.color,
      this.prefixWidget,
      this.suffixIcon,
      this.padding,
      this.obscure})
      : super(key: key);

  @override
  _CTextFieldState createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  bool isPass = false;
  DateTime? selectedDate;

  @override
  void initState() {
    setState(() {
      isPass = widget.isPassword;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? null,
      // height: 90,
      child: TextFormField(
        // expands: widget.expands ?? false,
        maxLines: (widget.expands ?? false) ? widget.maxline : 1,
        // minLines: null,
        controller: widget.controller ?? null,
        initialValue: widget.initialValue,
        enabled: widget.enabled ?? true,
        focusNode: widget.focusNode ?? widget.focusNode,
        onSaved: (value) {
          if (widget.onSaved != null) {
            return widget.onSaved!(value!);
          }
        },
        onChanged: (value) {
          if (widget.onSaved != null) {
            return widget.onSaved!(value);
          }
        },
        onFieldSubmitted: (value) {
          // _fieldFocusChange(context, widget.focusNode, widget.nextFocusNode);
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
        validator: widget.validation,
        textInputAction: widget.textInputAction != null
            ? widget.textInputAction
            : TextInputAction.next,
        style: widget.style != null && widget.enabled!
            ? widget.style
            : Controller.kblackSemiNormalStyle(context)
                .copyWith(fontSize: 12.sp),
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword,
        inputFormatters: widget.inputFormatters,
        // maxLines: widget.maxline,
        readOnly: widget.readOnly ?? false,
        onTap: widget.onPressed,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          enabled: widget.enabled!,
          fillColor: widget.color ?? Colors.white,
          // border: widget.textfieldBorder != null
          //     ? widget.textfieldBorder!
          //     : const UnderlineInputBorder(),
          filled: true,
          counterText: "",
          prefixText: widget.prefixWidget,
          prefixStyle: Controller.kwhiteSemiBoldNormalStyle(
                  context, black.withOpacity(0.5))
              .copyWith(fontSize: 13.sp),
          prefixIcon: widget.icon != null
              ? Container(
                  child: Icon(widget.icon,
                      size: 18.sp, color: black.withOpacity(0.5)),
                )
              : null,
          suffixText: widget.suffix_text,
          suffixStyle: Theme.of(context).textTheme.subtitle1,
          suffixIcon: widget.suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                  child: widget.suffixIcon!)
              : null,
          contentPadding: widget.enabled!
              ? EdgeInsets.symmetric(
                  vertical: widget.maxline! > 1 ? 1.5.h : 1.5.h,
                  horizontal: 5.w)
              : widget.padding != null
                  ? widget.padding!
                  : EdgeInsets.all(1.w),
          hintText: widget.hint_text,
          hintStyle: widget.hintTextStyle != null
              ? widget.hintTextStyle!
              : Theme.of(context).textTheme.subtitle1!.copyWith(color: grey),
          labelText: widget.lable_text ?? null,
          labelStyle: widget.style ??
              Theme.of(context).textTheme.subtitle1!.copyWith(color: grey),
          disabledBorder: widget.enabled!
              ? CommonView.enableBorder
              : widget.textfieldBorder,
          focusedErrorBorder: widget.maxline! > 1
              ? CommonView.errorBorderMaxLine
              : CommonView.errorBorder,
          errorBorder: widget.maxline! > 1
              ? CommonView.errorBorderMaxLine
              : CommonView.errorBorder,
          focusedBorder: widget.maxline! > 1
              ? CommonView.focusBorderMaxLine
              : widget.textfieldBorder != null && widget.enabled!
                  ? widget.textfieldBorder
                  : CommonView.focusBorder,

          enabledBorder: widget.maxline! > 1
              ? CommonView.enableBorderMaxLine
              : widget.textfieldBorder != null && widget.enabled!
                  ? widget.textfieldBorder
                  : CommonView.enableBorder,
          errorMaxLines: 2,
          errorStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocusNode) {
    currentFocus!.unfocus();
    if (nextFocusNode != null) {
      FocusScope.of(context).requestFocus(nextFocusNode);
    } else {
      Controller.dismissKeyboard(context);
    }
  }
}
