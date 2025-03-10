import 'package:flutter/material.dart';
import '../firebase_func/getmylessons.dart';
import '../firebase_func/lesson.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../lesson_widget.dart';

class MyLessonsScreen extends StatefulWidget {
  const MyLessonsScreen({super.key});

  @override
  State<MyLessonsScreen> createState() => _MyLessonsScreenState();
}

class _MyLessonsScreenState extends State<MyLessonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Мои занятия', style: TextStyle(fontSize: 20)),
        leadingWidth: 100,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Lesson>>(
        future: getMyLessons(FirebaseAuth.instance.currentUser!.uid),
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
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Запишитесь на занятие',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
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
    );
  }
}
