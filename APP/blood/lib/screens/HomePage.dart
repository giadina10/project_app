import 'package:blood/screens/StatisticPage.dart';
import 'package:blood/screens/login3.dart';
import 'package:blood/screens/profilePage.dart';
import 'package:blood/screens/what_air_pollution.dart';
import 'package:blood/screens/what_exposure.dart';
import 'package:flutter/material.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Widget _homeContent(HomeProvider provider) {
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
            TableCalendar(
              firstDay: DateTime.now(),
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
                _handleSelectedDate(provider, selectedDay);
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
                  fontWeight:FontWeight.bold,
                  color: Colors.black,
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
            if (_selectedDay == null)
              Center(
                child: Text(
                  'Scegli il giorno in cui vorresti donare',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              )
            else if (provider.isLoading)
              Center(child: CircularProgressIndicator())
            else
              Column(
                children: [
                  if (_selectedDay != null) Text('Ho preso i dati per $_selectedDay!'),
                  if (_selectedDay != null) Text(provider.risultatoalgoritmo),
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
              ),

              
     const SizedBox(
            height: 200, // inserito per mettere le due immagini hero in fondo: sarà da modificare sicuramente!
          ),
          const Text(
            "Learn Something More",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 250,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    // handle button press
                  },
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => WhatExposure())),
                          child: Hero(
                            tag: 'exposure',
                            child: Container(
                              width: 300,
                              height: 200,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/hero1.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "What's Exposure?",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    // handle button press
                  },
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => WhatAirPollution())),
                          child: Container(
                            width: 300,
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/hero2.jpg',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "What's Air Pollution?",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

  void _handleSelectedDate(HomeProvider provider, DateTime selectedDay) {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    DateTime today = DateTime.now();
    DateTime dayAfterTomorrow = today.add(Duration(days: 2));

    if (selectedDay.isAfter(tomorrow)) {//è tra due giorni
      provider.getData(selectedDay.subtract(Duration(days: 5)), selectedDay.subtract(Duration(days: 3)));
    } else if (selectedDay.isAfter(today) && selectedDay.isBefore(dayAfterTomorrow)) {
      provider.getData(selectedDay.subtract(Duration(days: 4)), selectedDay.subtract(Duration(days: 2)));
    } else {
      provider.getData(selectedDay.subtract(Duration(days: 3)), selectedDay.subtract(Duration(days: 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, _) {
        final provider = Provider.of<HomeProvider>(context);
        return Scaffold(
          appBar: _selIdx == 0
              ? AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/splashIcon.png',
                        scale: 10,
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
                  backgroundColor: Colors.red, // Imposta il colore di sfondo in rosso
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Adjust radius as needed
                  ),
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
          body: _selIdx == 0 ? _homeContent(provider) : ProfilePage(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFFf5f7f7),
            items: navBarItems,
            selectedItemColor: Colors.redAccent,
            currentIndex: _selIdx,
            onTap: _onItemTapped,
          ),
        );
      },
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