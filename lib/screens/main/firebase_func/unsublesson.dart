import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> unsubscribeFromLesson(String lessonId, String userId) async {
  final firestore = FirebaseFirestore.instance;
  final registrationDoc = await firestore
      .collection('userslessons')
      .where('lessonId', isEqualTo: lessonId)
      .where('userId', isEqualTo: userId)
      .limit(1)
      .get()
      .then(
        (snapshot) => snapshot.docs.isNotEmpty ? snapshot.docs.first : null,
      );

  if (registrationDoc == null) return false;
  await registrationDoc.reference.delete();
  final lessonRef = firestore.collection('lessons').doc(lessonId);
  final lessonSnapshot = await lessonRef.get();
  final availableSeats = (lessonSnapshot.data()?['ailableseats'] ?? 0) + 1;

  await lessonRef.update({'availableSeats': availableSeats});
  return true;
}
