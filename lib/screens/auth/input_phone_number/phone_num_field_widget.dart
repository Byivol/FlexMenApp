import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class NumPhoneField extends StatefulWidget {
  final TextEditingController controller;
  const NumPhoneField({super.key, required this.controller});
  @override
  State<NumPhoneField> createState() => _NumPhoneFieldState();
}

class _NumPhoneFieldState extends State<NumPhoneField> {
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        LibPhonenumberTextFormatter(
          phoneNumberType: PhoneNumberType.mobile,
          phoneNumberFormat: PhoneNumberFormat.national,
          country: CountryWithPhoneCode(
            phoneCode: '7',
            countryCode: 'RU',
            exampleNumberMobileNational: '+7 (900) 123-45-67',
            exampleNumberFixedLineNational: '+7 (495) 123-45-67',
            phoneMaskMobileNational: '+0 (000) 000-00-00',
            phoneMaskFixedLineNational: '+0 (000) 000-00-00',
            exampleNumberMobileInternational: '+7 900 123-45-67',
            exampleNumberFixedLineInternational: '+7 495 123-45-67',
            phoneMaskMobileInternational: '+0 000 000-00-00',
            phoneMaskFixedLineInternational: '+0 000 000-00-00',
            countryName: 'Russia',
          ),
          inputContainsCountryCode: true,
          shouldKeepCursorAtEndOfInput: true,
        ),
      ],
      controller: widget.controller,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: 'Номер телефона',
        border: OutlineInputBorder(),
      ),
      maxLength: 18,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Введите номер телефона";
        } else if (!value.startsWith('+7')) {
          return "Номер телефона должен начинаться с +7";
        }
        return null;
      },
    );
  }
}
