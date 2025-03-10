import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'firebase_func/lesson.dart';
import 'lesson_screen.dart';

class LessonWidget extends StatelessWidget {
  final Lesson lesson;

  const LessonWidget({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday =
        lesson.datetimestart.year == now.year &&
        lesson.datetimestart.month == now.month &&
        lesson.datetimestart.day == now.day;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => AddObjScr(
                    idLesson: lesson.id,
                    nameLesson: lesson.name,
                    colorBorder: Color(
                      int.parse('FF${lesson.color}', radix: 16),
                    ),
                  ),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 4,
                height: 60,
                color: Color(int.parse('FF${lesson.color}', radix: 16)),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              isToday
                  ? 'Сегодня\n${DateFormat('HH:mm').format(lesson.datetimestart)}\n${lesson.time} мин.     '
                  : '${DateFormat('dd.MM.yyyy').format(lesson.datetimestart)}\n${DateFormat('HH:mm').format(lesson.datetimestart)}\n${lesson.time} мин.',
              style: const TextStyle(
                height: 0,
                fontSize: 14,
                color: Color.fromARGB(169, 0, 0, 0),
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 30),
            RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: lesson.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '\nСвобоно: ${lesson.availableSeats}',
                    style: const TextStyle(
                      color: Color.fromARGB(169, 0, 0, 0),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextSpan(
                    text: '\n${lesson.nameteach}',
                    style: const TextStyle(
                      color: Color.fromARGB(169, 0, 0, 0),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Color.fromARGB(153, 0, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
