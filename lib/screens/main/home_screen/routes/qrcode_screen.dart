import 'package:flutter/material.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Номер карты', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  letterSpacing: 14,
                  fontSize: 55,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: 'THE',
                    style: TextStyle(fontWeight: FontWeight.w100),
                  ),
                  TextSpan(
                    text: 'FLEX',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150),
            Image.asset('assets/icons/qrcode.jpg', height: 80),
            SizedBox(height: 18),
            Column(
              children: [
                Text("025784", style: TextStyle(fontSize: 18)),
                SizedBox(height: 3),
                Text(
                  "Губин Евгений Александрович",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
