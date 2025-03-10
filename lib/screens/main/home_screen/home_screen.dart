import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../firebase_func/lesson.dart';
import '../lesson_widget.dart';
import 'routes/notification_screen.dart';
import 'routes/qrcode_screen.dart';
import '../refresh_indicator.dart';
import '../firebase_func/getlessons.dart';
import 'routes/schedule_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselSliderController _controller = CarouselSliderController();
  final List<String> _imgList = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var imgPath in _imgList) {
      precacheImage(AssetImage(imgPath), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 17,
                letterSpacing: 2,
              ),
              children: [
                TextSpan(text: 'THE'),
                TextSpan(
                  text: ' FLEX ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: 'men | Тюмень'),
              ],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QrCodeScreen()),
            );
          },
          icon: const Icon(Icons.qr_code_scanner),
        ),
        actions: [
          IconButton(
            onPressed: () async =>
                await launchUrl(Uri(scheme: 'tel', path: '89292615056')),
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: CheckMarkIndicator(
        onRefresh: _refreshScreen,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          clipBehavior: Clip.none,
          child: Column(
            children: [
              CarouselSlider.builder(
                carouselController: _controller,
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1,
                  autoPlay: true,
                  clipBehavior: Clip.hardEdge,
                ),
                itemCount: _imgList.length,
                itemBuilder: (context, index, realIndex) {
                  return Center(
                    child: Image.asset(
                      _imgList[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 255, 216, 87),
                    ),
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleScreen(),
                        ),
                      );
                    },
                    label: const Text(
                      'Расписание',
                      style: TextStyle(fontSize: 16),
                    ),
                    icon: const Icon(Icons.assignment),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.fromARGB(255, 255, 216, 87),
                          ),
                          iconAlignment: IconAlignment.end,
                          onPressed: () {},
                          label: const Text(
                            'Обратная связь',
                            style: TextStyle(fontSize: 16),
                          ),
                          icon: const Icon(Icons.sms_outlined),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.fromARGB(255, 255, 216, 87),
                          ),
                          iconAlignment: IconAlignment.end,
                          onPressed: () {},
                          label: const Text(
                            'Личный кабинет',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(Icons.account_circle_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    shape: Border.all(color: Colors.transparent),
                    tilePadding: EdgeInsets.symmetric(horizontal: 8),
                    initiallyExpanded: true,
                    onExpansionChanged: (e) {},
                    title: const Text("Ближайшие занятия:"),
                    children: [
                      FutureBuilder<List<Lesson>>(
                        future: getLessonsforDate(DateTime.now()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SizedBox(
                                height: 200,
                                child: Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.black,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Ошибка: ${snapshot.error}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text(
                                'Нет доступных занятий',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          } else {
                            final lessons = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lessons.length,
                              itemBuilder: (context, index) {
                                final lesson = lessons[index];
                                return LessonWidget(lesson: lesson);
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshScreen() async {
    setState(() {});
  }
}
