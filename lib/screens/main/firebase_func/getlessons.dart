import 'package:cloud_firestore/cloud_firestore.dart';

import 'lesson.dart';

Future<List<Lesson>> getLessonsforDate(DateTime date) async {
  final tzOffset = Duration(hours: 3);

  final startOfDay = DateTime(
    date.year,
    date.month,
    date.day,
  ).toUtc().add(tzOffset);
  final endOfDay = startOfDay
      .add(Duration(days: 1))
      .subtract(Duration(milliseconds: 1));

  final querySnapshot =
      await FirebaseFirestore.instance
          .collection('lessons')
          .where('datetimestart', isGreaterThanOrEqualTo: startOfDay)
          .where('datetimestart', isLessThanOrEqualTo: endOfDay)
          .get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data();
    return Lesson(
      id: doc.id,
      name: data['name'] ?? 'Без названия',
      nameteach: data['nameteach'] ?? 'Неизвестный преподаватель',
      availableSeats: data['availableseats'] ?? 0,
      datetimestart: (data['datetimestart'] as Timestamp).toDate().toLocal(),
      color: data['color'],
      time: data['time'],
    );
  }).toList();
}
