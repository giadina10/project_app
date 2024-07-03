import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/provider/FeaturesProvider.dart';
import 'package:blood/screens/login3.dart';
import 'package:blood/screens/profilePage.dart';
import 'package:blood/screens/hero_afterDonation.dart';
import 'package:blood/screens/hero_questions.dart';
import 'package:blood/screens/StatisticPage.dart';

// Definisco custom app bar
PreferredSizeWidget customAppBar(FeaturesProvider featuresProvider) {
  return AppBar(
    backgroundColor:Color.fromARGB(255, 240, 175, 175) ,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
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
      icon: Icon(Icons.home, color:  Color.fromARGB(255, 240, 175, 175)),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.account, color:  Color.fromARGB(255, 240, 175, 175)),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, _) {
        final provider = Provider.of<HomeProvider>(context);

        return Consumer<FeaturesProvider>(
          builder: (context, featuresProvider, child) {
            return Scaffold(
              appBar: _selIdx == 0 ? customAppBar(featuresProvider) : AppBar(backgroundColor: Color.fromARGB(255, 186, 235, 232)),
              backgroundColor: Color.fromARGB(255, 186, 235, 232),
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
                        fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto Serif',
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'When do you want to donate?',
                style: TextStyle(
                  fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto Serif',
                ),
              ),
            ),
            const SizedBox(height: 8), // Spazio tra la scritta e il calendario
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
                  'We will depict our recommandation here',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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
                          borderRadius: BorderRadius.circular(20),
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
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => DoubtsDonation())),
                            child: Hero(
                              tag: 'donation',
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
                                        'assets/images/hero1.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Frequently asked questions",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
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
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => Postdonation())),
                                    
                           child: Hero(
                              tag: 'information',
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
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Your post-donation information",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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

  void _handleSelectedDate(
      HomeProvider provider, DateTime selectedDay) {
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

  void _toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage3()),
    );
  }
}