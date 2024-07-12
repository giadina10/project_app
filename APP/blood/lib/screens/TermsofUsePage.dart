import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Terms of Use',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),
        ),
        backgroundColor: const Color.fromARGB(255, 186, 235, 232),
      ),
      backgroundColor: const Color.fromARGB(255, 186, 235, 232), // Colore di sfondo dello schermo
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Aggiunge spazio intorno al container per mostrare i bordi
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  '1. About these Terms of Use',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'These Terms of Use (the "Terms") set out the terms and conditions that apply to your use of the Donify (the "App"), developed for predicting the optimal day for blood donation using data related to calories, heart rate, and physical activity.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  '2. Licence',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'We grant you a non-transferable, non-exclusive licence to install and use the App on your mobile devices for your personal use, subject to these Terms.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  '3. Intellectual Property Rights',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'You acknowledge that all intellectual property rights relating to the App belong to us. You do not acquire any rights, title or interest in or to the App except as expressly set out in these Terms.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  '4. Use of Data',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'The App may collect and use data related to calories, heart rate, and physical activity to predict the optimal time for blood donation. Your use of such data will be governed by our Privacy Policy.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  '5. Disclaimer',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'The App is provided "as is" and "as available". We do not provide any warranties regarding the accuracy, reliability, or availability of the App or its services. Your use of the App is at your own risk.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  '6. Modifications and Termination',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'We reserve the right to modify, suspend, or terminate the App or any part of it without prior notice. We do not guarantee that the App will always be available or supported.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  '7. Governing Law and Jurisdiction',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'These Terms are governed by the laws of Italy. Any disputes arising out of or in connection with these Terms will be exclusively resolved by the competent courts of Italy.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
