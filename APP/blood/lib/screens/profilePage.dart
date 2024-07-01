import 'package:blood/screens/BloodDonorCenterPage.dart';
import 'package:blood/screens/SignUp.dart';
import 'package:blood/screens/TermsofUsePage.dart';
import 'package:blood/screens/login3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 235, 232),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 186, 235, 232), // Sfondo azzurro sfumato chiaro
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 186, 235, 232), // Sfondo azzurro sfumato chiaro
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
                    leading: const Icon(Icons.location_on, color: Color.fromARGB(255, 240, 175, 175)),
                    title: const Text("Our Blood Donor Center"),
                    trailing: const Icon(Icons.navigate_next), // Freccetta di navigazione
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BloodDonorCenterPage(),
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.description, color: Color.fromARGB(255, 240, 175, 175)),
                    title: const Text("Terms of Use"),
                    trailing: const Icon(Icons.navigate_next), // Freccetta di navigazione
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TermsOfUsePage(),
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.feedback, color: Color.fromARGB(255, 240, 175, 175)),
                    title: const Text("Send a Feedback"),
                    trailing: const Icon(Icons.navigate_next), // Freccetta di navigazione
                    onTap: () {
                      _showFeedbackDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "About us",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Pollutrack aims to improve the consciousness of the user to the air pollutants issue. The user can track the amount of pollutants they have been exposed to during the day and learn useful information about them.",
                style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.4)),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text("version 2.0.0"),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                    backgroundColor: const Color.fromARGB(255, 240, 175, 175), // Button background color
                    foregroundColor: Colors.black, // Black text color
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
          title: const Text('Write a Feedback'),
          content: Column(
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
              DropdownButtonFormField<int>(
                value: selectedRating,
                hint: const Text('Rate the app'),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
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
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logic to send feedback and handle rating
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
                Navigator.of(context).pop(); // Close the dialog
                await _logout(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
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
      MaterialPageRoute(builder: ((context) => const LoginPage3())),
    );
  }
}
