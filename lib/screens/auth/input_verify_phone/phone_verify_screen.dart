import 'dart:async' show Timer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main/main_screen.dart';
import 'pin_code_field_widget.dart';

class PhoneVerifyScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const PhoneVerifyScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  TextEditingController controller = TextEditingController();
  bool _isLoading = false;
  late Timer _timer;
  int _start = 5;
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Введите код"),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                "Мы отправили 6-значный код\nна этот ${widget.phoneNumber} номер телефона",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),
              PinCodeFieldWidget(
                controller: controller,
                onCompleted: onPinCodeCompleted,
                selectedColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _isButtonDisabled
                        ? null
                        : () {
                            setState(() {
                              _startTimer();
                            });
                          },
                    child: Text(
                      "Отправить код повторно",
                      style: TextStyle(
                        color: _isButtonDisabled ? Colors.grey : Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      "00:${_start.toString().padLeft(2, '0')}",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Future<void> onPinCodeCompleted(String pinCode) async {
    try {
      setState(() {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator.adaptive());
          },
        );
        _isLoading = true;
      });
      final cred = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: pinCode,
      );
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.setSettings(appVerificationDisabledForTesting: true);
      await auth.signInWithCredential(cred);

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false,
        );
      }
    } catch (ex) {
      if (mounted) {
        setState(() {
          if (_isLoading) {
            Navigator.pop(context);
            _isLoading = false;
          }
        });
      }
    }
  }

  void _startTimer() {
    _isButtonDisabled = true;
    _start = 5;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer.cancel();
          _isButtonDisabled = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }
}
