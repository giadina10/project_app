import 'package:blood/screens/SignUp.dart';
import 'package:blood/screens/login3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false, // Rimuovi il pulsante di ritorno alla homepage
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Text("Info about you and your preferences",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Account",
              style: TextStyle(fontSize: 16),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PersonalInfo()));
                  },
                ),
                Divider(
                  color: Color(0xFFFFFFFF),
                  thickness: 3,
                ),
                ListTile(
                  leading: Text("Send a Feedback", style: TextStyle(fontSize: 14)),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () {}
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About us",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Pollutrack aims to improve the consciousness of the user to the air pollutants issue. The user can track the amount of pollutants they has been exposed to during the day and learn useful information about them.",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.4)),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text("version 2.0.0"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 12)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF384242))),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
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
        MaterialPageRoute(builder: ((context) => const LoginPage3())));
  }
}