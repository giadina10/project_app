import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/provider/FeaturesProvider.dart';
import 'package:blood/screens/settings.dart';
import 'package:blood/screens/hero_afterDonation.dart';
import 'package:blood/screens/hero_questions.dart';
import 'package:blood/screens/StatisticPage.dart';

// Definisco custom app bar
PreferredSizeWidget customAppBar(FeaturesProvider featuresProvider) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 240, 175, 175),
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
      icon: Icon(Icons.home, color: Color.fromARGB(255, 240, 175, 175)),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings, color: Color.fromARGB(255, 240, 175, 175)),
      label: 'Settings',
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
              appBar: _selIdx == 0
                  ? customAppBar(featuresProvider)
                  : AppBar(
                      backgroundColor: const Color.fromARGB(255, 186, 235, 232),
                    ),
              backgroundColor: Color.fromARGB(255, 186, 235, 232),
              body: _selIdx == 0 ? _homeContent(provider) : Settings(),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color(0xFFf5f7f7),
                items: navBarItems,
                currentIndex: _selIdx,
                onTap: _onItemTapped,
                selectedItemColor: Color.fromARGB(255, 240, 175, 175),
                unselectedItemColor: Colors.black,
              ),
            );
          },
        );
      },
    );
  }

  Widget _homeContent(HomeProvider provider) {
    RichText advice = getAdvice(provider.risultatoalgoritmo);
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
                'When would you like to donate?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.black,
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
                weekendStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              availableCalendarFormats: const {
                CalendarFormat.week: 'Week',
              },
            ),
            const SizedBox(height: 20),
            if (_selectedDay == null)
              Center(
                child: Text(
                  "You'll find our recommendation for the upcoming three days when you click on the calendar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto Serif',
                  ),
                ),
              )
            else if (provider.isLoading)
              Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 240, 175, 175),
              ))
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 350,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            advice,
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
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 12),
                                backgroundColor:
                                    const Color.fromARGB(255, 240, 175, 175),
                                foregroundColor: Colors.black,
                              ),
                              child: const Text('Go to statistics'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 30),
            Center(
              child: const Text(
                "Learn Something More",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto Serif',
                  fontWeight: FontWeight.bold
                ),
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
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
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
                                    image:
                                        AssetImage('assets/images/hero1.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Frequently asked questions",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
                                    image:
                                        AssetImage('assets/images/hero2.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Your post-donation information",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
  //DateTime targetDate = DateTime(2023,7,19); // Data desiderata: 19 luglio 2023
  DateTime today = DateTime.now();
  DateTime tomorrow = today.add(Duration(days: 1));
  DateTime dayAfterTomorrow = today.add(Duration(days: 2));

  if (selectedDay.day == dayAfterTomorrow.day) {
    provider.getData(
      today.subtract(Duration(days: 7)),
      today.subtract(Duration(days: 1)),
      7,
    ); // Prende i dati per i 7 giorni precedenti al 19 luglio 2023
  } else if (selectedDay.day == tomorrow.day) {
    provider.getData(
      today.subtract(Duration(days: 5)),
      today.subtract(Duration(days: 1)),
      5,
    ); // Prende i dati per i 5 giorni precedenti al 19 luglio 2023
  } else {
    provider.getData(
      today.subtract(Duration(days: 3)),
      today.subtract(Duration(days: 1)),
      3,
    ); // Prende i dati per i 3 giorni precedenti al 19 luglio 2023
  }
}

  RichText getAdvice(String risultatoAlgoritmo) {
    String adviceText;
    switch (risultatoAlgoritmo) {
      case '1':
        adviceText =
            'Alert! Your heart rate is too high. It is advisable to maintain a healthy lifestyle and continue monitoring your heart rate. It may be best to avoid donating blood until your heart rate stabilizes.'; //battito cardiaco troppo alto
        break;
      case '2':
        adviceText =
            'Great job! Your step count, calorie burn, and heart rate are all in optimal ranges. You are an excellent candidate for blood donation. Keep it up!'; //battiti+passi+calorie nel range corretto.
        break;
      case '3':
        adviceText =
            "Well done! You've achieved a great number of steps and maintained a healthy heart rate. However, considering the significant calorie burn during blood donation (approximately 650 kcal per liter of blood donated), it's advisable to eat something nutritious before donating. This ensures you have enough energy and nutrients to support your body through the process. Remember, donating blood is a noble act, and taking care of yourself before and after is crucial for a smooth and positive experience.";
        //tante calorie bruciate
        break;
      case '4':
        adviceText =
            " Consider incorporating more physical activity into your daily routine. Aim for at least 30 minutes of moderate-intensity exercise most days of the week, such as brisk walking, cycling, or swimming. This can help maintain a healthy heart rate and prepare you for blood donation. Remember, donating blood burns calories, so ensuring a balanced diet and hydration before donation is important.";
        //non abbastanza attività fisica.
        break;
      default:
        adviceText =
            ''; //non dovrebbe mai uscire, serve perchè nell'algoritmo dobbiamo valutare tutti i range di età, ma alcuni non verranno mai fuori
      //range età (18-65). 
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: adviceText,
          ),
        ],
      ),
    );
  }
}
