import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';

import '../../firebase_func/getlessons.dart';
import '../../firebase_func/lesson.dart';
import '../../lesson_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleScreen> {
  final CalendarWeekController _controller = CalendarWeekController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: -1,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Расписание', style: TextStyle(fontSize: 20)),
        leadingWidth: 100,
        leading: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: CalendarWeek(
              controller: _controller,
              height: 110,
              showMonth: true,
              dayShapeBorder: BoxShape.circle,
              pressedDateBackgroundColor: Colors.black,
              todayDateStyle: TextStyle(color: Colors.black),
              dateStyle: TextStyle(color: Colors.black),
              pressedDateStyle: TextStyle(color: Colors.white),
              dayOfWeekStyle: TextStyle(fontSize: 10, color: Colors.black),
              weekendsStyle: TextStyle(fontSize: 20, color: Colors.black),
              minDate: DateTime.now().add(Duration(days: -3)),
              maxDate: DateTime.now().add(Duration(days: 10)),
              dayOfWeek: ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'],
              onDatePressed: (DateTime datetime) {
                setState(() {
                  _selectedDate = datetime;
                });
              },
              monthViewBuilder: (DateTime time) {
                int monthIndex = time.month - 1;
                final String monthName = [
                  'ЯНВАРЬ',
                  'ФЕВРАЛЬ',
                  'МАРТ',
                  'АПРЕЛЬ',
                  'МАЙ',
                  'ИЮНЬ',
                  'ИЮЛЬ',
                  'АВГУСТ',
                  'СЕНТЯБРЬ',
                  'ОКТЯБРЬ',
                  'НОЯБРЬ',
                  'ДЕКАБРЬ',
                ][monthIndex];

                return Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '$monthName ${time.year}',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Lesson>>(
              future: getLessonsforDate(_selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.black,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Ошибка загрузки данных.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Занятия на эту дату\n не найдены.',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  final lessons = snapshot.data!;
                  return ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      return LessonWidget(lesson: lesson);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
