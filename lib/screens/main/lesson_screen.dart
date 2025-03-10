import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theflexmen/screens/main/firebase_func/issublesson.dart';

import 'firebase_func/sublesson.dart';
import 'firebase_func/unsublesson.dart';

class AddObjScr extends StatelessWidget {
  final String idLesson;
  final String nameLesson;
  final Color colorBorder;
  const AddObjScr({
    super.key,
    required this.nameLesson,
    required this.colorBorder,
    required this.idLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -1,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(nameLesson, style: const TextStyle(fontSize: 20)),
        leadingWidth: 100,
        leading: Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Закрыть',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: colorBorder, height: 4.0),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(nameLesson),
            const SizedBox(height: 20),
            FutureBuilder<bool>(
              future: checkUserLesson(
                FirebaseAuth.instance.currentUser!.uid,
                idLesson,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox.shrink();
                }

                return SubButtonWidget(
                  isSubLesson: snapshot.data!,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  idLesson: idLesson,
                  idUser: FirebaseAuth.instance.currentUser!.uid,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubButtonWidget extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final String idLesson;
  final String idUser;
  final bool isSubLesson;

  const SubButtonWidget({
    super.key,
    required this.idLesson,
    required this.idUser,
    required this.isSubLesson,
    this.padding = EdgeInsets.zero,
  });
  @override
  State<SubButtonWidget> createState() => _SubButtonWidgetState();
}

class _SubButtonWidgetState extends State<SubButtonWidget> {
  bool _isSubLesson = false;
  @override
  void initState() {
    super.initState();
    _isSubLesson = widget.isSubLesson;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: SizedBox(
        height: 52,
        width: double.infinity,
        child: FilledButton(
          onPressed: () async => _subscriptionLesson(widget.idLesson),
          child: Text(_isSubLesson ? "Отписаться" : "Записаться"),
        ),
      ),
    );
  }

  Future<void> _subscriptionLesson(String idLesson) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          const Center(child: CircularProgressIndicator.adaptive()),
    );
    if (_isSubLesson) {
      await unsubscribeFromLesson(
        idLesson,
        FirebaseAuth.instance.currentUser!.uid,
      );
      setState(() => _isSubLesson = false);
    } else {
      await subLessonforId(idLesson, FirebaseAuth.instance.currentUser!.uid);
      setState(() => _isSubLesson = true);
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
