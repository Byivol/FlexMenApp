import 'package:cloud_firestore/cloud_firestore.dart';
import 'lesson.dart';

Future<List<Lesson>> getMyLessons(String userId) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('userslessons')
      .where('userId', isEqualTo: userId)
      .get();
  List<Lesson> lessons = [];
  for (var doc in querySnapshot.docs) {
    final data = doc.data();
    final lessonId = data['lessonId'];
    final lessonSnapshot = await FirebaseFirestore.instance
        .collection('lessons')
        .doc(lessonId)
        .get();

    if (lessonSnapshot.exists) {
      final lessonData = lessonSnapshot.data()!;
      lessons.add(
        Lesson(
          id: lessonSnapshot.id,
          name: lessonData['name'] ?? 'Без названия',
          nameteach: lessonData['nameteach'] ?? 'Неизвестный преподаватель',
          availableSeats: lessonData['ailableseats'] ?? 0,
          datetimestart:
              (lessonData['datetimestart'] as Timestamp).toDate().toLocal(),
          color: lessonData['color'],
          time: lessonData['time'],
        ),
      );
    }
  }
  return lessons;
}
