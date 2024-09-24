import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant/color.dart';
import '../constant/constantTextStyle.dart';
import '../constant/font_family.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.regex,
    required this.type,
    required this.keyBoardType,
    required this.isEnabled,
    required this.isOptional,
    required this.inValidMsg,
    required this.placeHolderMsg,
    required this.emptyFieldMsg,
    required this.controller,
    required this.focus,
    required this.isSecure,
    required this.maxLength,
    this.labelMsg,
    this.prefixIcon,
    this.sufixIcon,
    this.onChange,
    this.isMaxlineMore,
    this.isNoNeededCapital,
    this.minLine,
    this.maxLine,
    this.fillColor,
    this.keyboardButtonType,
    this.onTap,
    this.isReadOnly,
    this.roundCornder,
    this.isNoHorizontalPadding,
    this.borderColor,
  }) : super(key: key);
  final String? regex;
  final String type;
  final TextInputType keyBoardType;
  final bool isEnabled;
  final bool isOptional;
  final bool isSecure;
  final bool? isNoNeededCapital;
  final String inValidMsg;
  final String placeHolderMsg;
  final String? labelMsg;
  final String emptyFieldMsg;
  final int maxLength;
  final TextEditingController controller;
  final FocusNode focus;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool? isMaxlineMore;
  final int? maxLine;
  final int? minLine;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputAction? keyboardButtonType;
  final Function? onTap;
  final Function? onChange;
  final bool? isReadOnly;
  final double? roundCornder;
  final bool? isNoHorizontalPadding;
  @override
  State<CustomTextField> createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), boxShadow: const [
        BoxShadow(
          color: Colors.transparent,
          offset: Offset.zero,
          spreadRadius: 2,
          blurRadius: 7,
        )
      ]),
      child: TextField(
          style: widget.focus.hasFocus ? TextStyles().textFieldFocusText : TextStyles().textFieldText,
          enabled: widget.isEnabled,
          scrollPadding: EdgeInsets.only(bottom: 10.h),
          autofillHints: const [AutofillHints.email],
          maxLength: widget.maxLength,
          keyboardType: widget.keyBoardType,
          cursorColor: AppColors().grayColor,
          controller: widget.controller,
          focusNode: widget.focus,
          textCapitalization: ((widget.isSecure) || (widget.isNoNeededCapital != null) || widget.keyBoardType == TextInputType.url) ? TextCapitalization.none : TextCapitalization.sentences,
          readOnly: widget.isReadOnly ?? false,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          onChanged: (value) {
            if (widget.onChange != null) {
              widget.onChange!();
            }
          },
          inputFormatters: widget.regex != null
              ? [FilteringTextInputFormatter.allow(RegExp(widget.regex!))]
              : widget.minLine != null
                  ? widget.minLine! > 1
                      ? []
                      : null
                  : null,
          obscureText: widget.isSecure,
          minLines: widget.isMaxlineMore != null ? widget.minLine ?? 5 : 1,
          maxLines: widget.isMaxlineMore != null ? widget.maxLine ?? 5 : 1,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: widget.keyboardButtonType,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 1.65.h, bottom: 1.65.h, left: widget.prefixIcon != null ? 0 : 6.w, right: widget.sufixIcon != null ? 0 : 6.w),
              counterText: "",
              prefixIcon: widget.prefixIcon != null
                  ? Container(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: widget.prefixIcon ?? const SizedBox(),
                    )
                  : null,
              suffixIcon: widget.sufixIcon != null
                  ? Container(
                      padding: widget.sufixIcon != null ? const EdgeInsets.only(left: 20, right: 20) : const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                      child: widget.sufixIcon ?? const SizedBox(),
                    )
                  : null,
              fillColor: widget.fillColor ?? AppColors().footerColor,
              filled: true,
              hintStyle: TextStyle(
                fontFamily: Appfonts.family1Medium,
                fontSize: 16,
                color: AppColors().placeholderColor,
              ),
              hintText: widget.placeHolderMsg,
              labelText: widget.labelMsg,
              labelStyle: TextStyle(
                fontFamily: Appfonts.family1Medium,
                fontSize: 16,
                color: widget.focus.hasFocus ? AppColors().DarkText : AppColors().placeholderColor,
              ),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.roundCornder != null ? widget.roundCornder! : 4),
                borderSide: BorderSide(color: widget.borderColor != null ? widget.borderColor! : AppColors().borderColor, width: 5.sp),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.roundCornder != null ? widget.roundCornder! : 4),
                borderSide: BorderSide(color: AppColors().grayBorderColor, width: 1.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.roundCornder != null ? widget.roundCornder! : 100.w),
                borderSide: BorderSide(color: widget.borderColor != null ? widget.borderColor! : AppColors().borderColor, width: 1.0),
              ))),
    );
  }
}
