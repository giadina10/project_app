import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/provider/FeaturesProvider.dart';
import 'package:blood/screens/login3.dart';
import 'package:blood/screens/profilePage.dart';
import 'package:blood/screens/what_air_pollution.dart';
import 'package:blood/screens/what_exposure.dart';
import 'package:blood/screens/StatisticPage.dart';

// Definisco custom app bar
PreferredSizeWidget customAppBar(FeaturesProvider featuresProvider) {
  return AppBar(
    backgroundColor: Colors.red,
    centerTitle: true,
    title: const Text(
      'Homepage',
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto Serif',
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(110.0),
      child: Container(
        padding: const EdgeInsets.only(left: 30, bottom: 20),
        child: Row(
          children: [
            Icon(
              Icons.person_outline_rounded,
              size: 60,
              color: Color.fromARGB(255, 250, 247, 247),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<FeaturesProvider>(
                    builder: (context, featuresProvider, child) {
                      return Text(
                        featuresProvider.fullName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  Consumer<FeaturesProvider>(
                    builder: (context, featuresProvider, child) {
                      return Text(
                        featuresProvider.email,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'Homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? fullName;
  String? email;
  int _selIdx = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? selectedAvatar; // Variabile per memorizzare l'avatar selezionato
  bool isAvatarSelected = false; // Variabile per tracciare la selezione dell'avatar
  void _onItemTapped(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  



  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.redAccent),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.account, color: Colors.redAccent),
      label: 'Profile',
    ),
  ];

  @override
  void initState() {
    super.initState();
    
  }




  Widget _homeContent(HomeProvider provider) {
    String advice = getAdvice(provider.risultatoalgoritmo);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hello, ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto Serif',
                  ),
                ),
                Consumer<FeaturesProvider>(
                  builder: (context, featuresProvider, child) {
                    return Text(
                      featuresProvider.name,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Roboto Serif',
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
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
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white,
                ),
                todayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.redAccent),
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Roboto Serif',
                  ),
                ),
              )
            else if (provider.isLoading)
              Center(child: CircularProgressIndicator())
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_selectedDay != null)
                                Text(
                                  provider.risultatoalgoritmo,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Text(
                                advice,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 80),
            const Text(
              "Learn Something More",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto Serif',
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 250,
              child: ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => WhatExposure())),
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
                                    image: AssetImage('assets/images/hero1.jpg'),
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
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => WhatAirPollution())),
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
                                  image: AssetImage('assets/images/hero2.jpg'),
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
            ),
          ],
        ),
      ),
    );
  }

  void _handleSelectedDate(HomeProvider provider, DateTime selectedDay) {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    DateTime today = DateTime.now();
    DateTime dayAfterTomorrow = today.add(Duration(days: 2));

    if (selectedDay.isAfter(tomorrow)) {
      provider.getData(
          selectedDay.subtract(Duration(days: 9)),
          selectedDay.subtract(Duration(days: 3)),
          7); //prende 7 giorni se clicco dopodomani
    } else if (selectedDay.isAfter(today) &&
        selectedDay.isBefore(dayAfterTomorrow)) {
      provider.getData(
          selectedDay.subtract(Duration(days: 6)),
          selectedDay.subtract(Duration(days: 2)),
          5); //prende 5 giorni indietro rispetto al giorno cliccato
    } else {
      provider.getData(selectedDay.subtract(Duration(days: 3)),
          selectedDay.subtract(Duration(days: 1)), 3); //prende 3 giorni
    }
  }

  String getAdvice(String risultatoAlgoritmo) {
    switch (risultatoAlgoritmo) {
      case '1':
        return 'Consiglio: Mantieni uno stile di vita sano e continua così!';
      case '2':
        return 'Consiglio: Cerca di fare più esercizio fisico ogni giorno.';
      case '3':
        return 'Consiglio: PERFETTOOOOOOO.';
      case '4':
        return 'Consiglio: Prova a ridurre lo stress con tecniche di rilassamento.';
      default:
        return 'Consiglio: Continua a monitorare i tuoi parametri di salute.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, _) {
        final provider = Provider.of<HomeProvider>(context);
        
        return Consumer<FeaturesProvider>(
          builder: (context, featuresProvider, child) {
            return Scaffold(
              appBar: _selIdx == 0
                  ? customAppBar(featuresProvider)
                  : AppBar(),
              body: _selIdx == 0 ? _homeContent(provider) : Profile(),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color(0xFFf5f7f7),
                items: navBarItems,
                currentIndex: _selIdx,
                onTap: _onItemTapped,
                selectedItemColor: Colors.redAccent,
                unselectedItemColor: Colors.black,
              ),
            );
          },
        );
      },
    );
  }

  void _toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage3()),
    );
  }
}