import 'package:cloud_firestore/cloud_firestore.dart';

import 'lesson.dart';

Future<List<Lesson>> getLessonsforDate(DateTime date) async {
  final tzOffset = Duration(hours: 3, days: -1);

  final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0)
      .toUtc()
      .add(tzOffset);
  final endOfDay =
      DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 999)
          .toUtc()
          .add(tzOffset);

  final querySnapshot = await FirebaseFirestore.instance
      .collection('lessons')
      .where('datetimestart', isGreaterThanOrEqualTo: startOfDay)
      .where('datetimestart', isLessThanOrEqualTo: endOfDay)
      .get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data();
    final timestamp = data['datetimestart'] as Timestamp;

    final dateTimeStart = timestamp.toDate().toLocal();

    return Lesson(
      id: doc.id,
      name: data['name'] ?? 'Без названия',
      nameteach: data['nameteach'] ?? 'Неизвестный преподаватель',
      availableSeats: data['ailableseats'] ?? 0,
      datetimestart: dateTimeStart,
      color: data['color'] ?? 'FFFFFF',
      time: data['time'] ?? 0,
    );
  }).toList();
}
