import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onCompleted;
  final Color selectedColor;
  const PinCodeFieldWidget({
    super.key,
    required this.controller,
    required this.onCompleted,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.center,
      pinTheme: PinTheme(
        activeFillColor: Colors.transparent,
        shape: PinCodeFieldShape.box,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 8),
        borderRadius: BorderRadius.circular(15),
        fieldHeight: 68,
        fieldWidth: 48,
        borderWidth: 1,
        errorBorderWidth: 1,
        activeBorderWidth: 1,
        disabledBorderWidth: 1,
        selectedBorderWidth: 1,
        inactiveBorderWidth: 1,
        inactiveFillColor: Colors.transparent,
        selectedFillColor: Colors.transparent,
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        selectedColor: selectedColor,
        errorBorderColor: Colors.red,
      ),
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: controller,
      onCompleted: onCompleted,
      onChanged: (s) {},
    );
  }
}
