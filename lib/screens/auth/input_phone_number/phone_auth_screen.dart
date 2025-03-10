import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../input_verify_phone/phone_verify_screen.dart';
import 'phone_num_field_widget.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  PhoneAuthScreenState createState() => PhoneAuthScreenState();
}

class PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Image imageLogo = Image.asset(
      Theme.of(context).brightness != Brightness.dark
          ? 'assets/icons/logo.png'
          : 'assets/icons/logo_white.png',
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                imageLogo,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NumPhoneField(controller: _phoneNumberController),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async => _validateAndSubmit(),
                    child: Text("SEND"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(Image.asset('assets/icons/logo.png').image, context);
    precacheImage(Image.asset('assets/icons/logo_white.png').image, context);
    super.didChangeDependencies();
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder:
              (BuildContext context) =>
                  Center(child: CircularProgressIndicator.adaptive()),
        );
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.setSettings(
          appVerificationDisabledForTesting: true,
        );
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          verificationCompleted: (phoneAuthCredential) {},
          codeSent: (verificationId, forceResendingToken) {
            setState(() {
              if (_isLoading) {
                Navigator.pop(context);
                _isLoading = false;
              }
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => PhoneVerifyScreen(
                      verificationId: verificationId,
                      phoneNumber: _phoneNumberController.text,
                    ),
              ),
            );
          },
          verificationFailed: (FirebaseAuthException error) {
            setState(() {
              if (_isLoading) {
                Navigator.pop(context);
                _isLoading = false;
              }
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {
            setState(() {
              if (_isLoading) {
                Navigator.pop(context);
                _isLoading = false;
              }
            });
          },
        );
      } catch (e) {
        setState(() {
          if (_isLoading) {
            Navigator.pop(context);
            _isLoading = false;
          }
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Произошла ошибка: $e")));
      }
    }
  }
}
