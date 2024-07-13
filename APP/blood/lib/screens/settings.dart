import 'package:blood/screens/BloodDonorCenterPage.dart';
import 'package:blood/screens/SignUp.dart';
import 'package:blood/screens/TermsofUsePage.dart';
import 'package:blood/screens/activity_levelpage.dart';
import 'package:blood/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 235, 232),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 34),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 186, 235, 232), 
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 186, 235, 232),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Info about you and your preferences",
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
              const SizedBox(height: 30),
              const Text(
                "Account",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.person, color: Color.fromARGB(255, 240, 175, 175)),
                    title: const Text("Edit Profile"),
                    trailing: const Icon(Icons.navigate_next), // Freccetta di navigazione
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PersonalInfo(),
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.fitness_center, color: Color.fromARGB(255, 240, 175, 175)),
                    title: const Text("Activity Level"),
                    trailing: const Icon(Icons.navigate_next), // Freccetta di navigazione
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  ActivityLevelPage(), 
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Color.fromARGB(255, 240, 175, 175)),
                    title: const Text("Our Blood Donor Center"),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BloodDonorCenterPage(),
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.description, color: Color.fromARGB(255, 240, 175, 175)),
                    title: const Text("Terms of Use"),
                    trailing: const Icon(Icons.navigate_next), 
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TermsOfUsePage(),
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.feedback, color: Color.fromARGB(255, 240, 175, 175)),
                    title: const Text("Send a Feedback"),
                    trailing: const Icon(Icons.navigate_next), 
                    onTap: () {
                      _showFeedbackDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20), // Spazio aggiunto tra Send a Feedback e Log Out
              SizedBox(height: 20), // Spazio aggiunto per separare Send a Feedback e Log Out
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                    backgroundColor: const Color.fromARGB(255, 240, 175, 175), 
                    foregroundColor: Colors.black, 
                  ),
                  child: const Text('Log Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showFeedbackDialog(BuildContext context) async {
    int? selectedRating;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFE4E1), 
          title: const Text(
            'Write a Feedback',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your feedback here...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                const Text(
                  'How likely is it that you will recommend Donify to a family member or friend on a scale from 1 to 10?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  value: selectedRating,
                  hint: const Text('Rate the app'),
                  items: List.generate(10, (index) => index + 1).map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    selectedRating = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                
                print('Feedback: ${selectedRating ?? 'No rating selected'}');
                Navigator.of(context).pop();
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); 
                await _logout(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: ((context) => const LoginPage())),
    );
  }
}
