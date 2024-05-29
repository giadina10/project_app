import 'package:blood/screens/StatisticPage.dart';
import 'package:blood/screens/login3.dart';
import 'package:blood/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:blood/screens/horizontal_week_calendar.dart';
import 'package:table_calendar/table_calendar.dart'; // Importa il widget del calendario

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'Homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  int _selIdx = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _onItemTapped(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.account),
      label: 'Profile',
    ),
  ];

  Widget _homeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (name != null)
              Text(
                'Hello, $name!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            const SizedBox(height: 20),
            Consumer<HomeProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      // Aggiungi il calendario dentro al Consumer
                      TableCalendar(
                        firstDay: DateTime.now().subtract(Duration(days: 2)),
                        lastDay: DateTime.now().add(Duration(days: 2)),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        calendarFormat: CalendarFormat.week,
                        onFormatChanged: (format) {},
                        onPageChanged: (focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                          });
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: _selectedDay == _focusedDay
                                ? Colors.red
                                : Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          todayTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(color: Colors.red),
                        ),
                        availableCalendarFormats: const {
                          CalendarFormat.week: 'Week',
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Ho preso i dati!'),
                      Text(provider.risultatoalgoritmo),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Stats(provider),
                            ),
                          );
                        },
                        child: const Text('Go to statistics'),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString('name') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, _) => Scaffold(
        appBar: _selIdx == 0
            ? AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/splashIcon.png',
                      scale: 8,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Donify',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CustomFont',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                backgroundColor:
                    Colors.red, // Imposta il colore di sfondo in rosso
              )
            : AppBar(
                title: const Text('Profile page'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      _toLogin(context);
                    },
                  ),
                ],
              ),
        body: _selIdx == 0 ? _homeContent() : ProfilePage(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFf5f7f7),
          items: navBarItems,
          currentIndex: _selIdx,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  _toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage3()),
    );
  }
}
