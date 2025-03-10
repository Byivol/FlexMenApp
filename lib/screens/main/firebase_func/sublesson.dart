import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> subLessonforId(String lessonId, String userId) async {
  try {
    final lessonRef = FirebaseFirestore.instance
        .collection('lessons')
        .doc(lessonId);
    final lessonSnapshot = await lessonRef.get();
    if (!lessonSnapshot.exists) {
      return false;
    }
    await FirebaseFirestore.instance.collection('userslessons').add({
      'lessonId': lessonId,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
    return true;
  } catch (e) {
    return false;
  }
}
