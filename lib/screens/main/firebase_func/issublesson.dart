import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkUserLesson(String userId, String lessonId) async {
  return (await FirebaseFirestore.instance
          .collection('userslessons')
          .where('lessonId', isEqualTo: lessonId)
          .where('userId', isEqualTo: userId)
          .get())
      .docs
      .isNotEmpty;
}
