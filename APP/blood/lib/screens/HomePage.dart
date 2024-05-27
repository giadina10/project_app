import 'package:blood/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:blood/screens/horizontal_week_calendar.dart'; // Importa il widget del calendario

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'Homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  int _selIdx = 0;

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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (name != null)
              Text('Hello, $name!', style: TextStyle(fontSize: 24)),
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
                      const Text('Ho preso i dati!'),
                      Text(provider.risultatoalgoritmo),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selIdx = 1;
                          });
                        },
                        child: const Text('Go to Profile Page'),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            // Aggiungi il calendario qui
            HorizontalWeekCalendar(
              onDateChange: (DateTime date) {
                // Puoi gestire la selezione della data qui se necessario
              },
              onWeekChange: (List<DateTime> list) {
                // Puoi gestire il cambio della settimana qui se necessario
              },
              minDate: DateTime.now().subtract(const Duration(days: 365)),
              maxDate: DateTime.now().add(const Duration(days: 365)),
              initialDate: DateTime.now(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impact Data'),
      ),
      body: IndexedStack(
        index: _selIdx,
        children: [
          _homeContent(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFf5f7f7),
        items: navBarItems,
        currentIndex: _selIdx,
        onTap: _onItemTapped,
      ),
    );
  }
}
