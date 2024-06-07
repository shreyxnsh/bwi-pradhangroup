import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pradhangroup/main.dart';


class LoginScreenTextFeild extends StatelessWidget {
  final double? height;
  final TextEditingController? controller;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isBigTextField;
  final int? maxLength;
  final bool? expands;
  final String? counterText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;

  const LoginScreenTextFeild({
    this.height,
    this.enabled,
    this.maxLines,
    this.onChanged,
    this.hintText,
    this.inputFormatters,
    this.isBigTextField,
    this.expands,
    this.minLines,
    this.controller,
    this.contentPadding,
    this.focusNode,
    this.maxLength,
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.onTap,
    this.textInputAction,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.counterText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final dark = FHelperFunctions.isDarkMode(context);

    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * (63 / 840),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        maxLines: maxLines ?? 1,
        minLines: minLines,
        inputFormatters: inputFormatters,
        expands: expands ?? false,
        maxLength: maxLength,
        onChanged: onChanged,
        focusNode: focusNode,
        style:  TextStyle(color: '0095D9'.toColor()), // Set text color
        decoration: InputDecoration(
          counterText: counterText,
          hintText: hintText,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.titleMedium,
          contentPadding: contentPadding,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: '0095D9'.toColor()), // Set border color
            borderRadius: BorderRadius.all(Radius.circular(20.0)), // Set border radius
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: '0095D9'.toColor()), // Set border color
            borderRadius: BorderRadius.all(Radius.circular(20.0)), // Set border radius
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color:'0095D9'.toColor()), // Set border color
            borderRadius: BorderRadius.all(Radius.circular(20.0)), // Set border radius
          ),
          filled: true,
          fillColor: 'F4F5FA'.toColor(),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        onTap: onTap,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}

