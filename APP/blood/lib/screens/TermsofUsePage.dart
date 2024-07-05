import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Use'),
        backgroundColor: Color.fromARGB(255, 186, 235, 232),
      ),
      body: Container(
        decoration: BoxDecoration(
          color:  Color.fromARGB(255, 186, 235, 232),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Terms of Use for Blood Prediction App',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                '1. About these Terms of Use',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'These Terms of Use (the "Terms") set out the terms and conditions that apply to your use of the Blood Prediction App (the "App"), developed for predicting the optimal day for blood donation using data related to calories, heart rate, and physical activity.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                '2. Licence',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'We grant you a non-transferable, non-exclusive licence to install and use the App on your mobile devices for your personal use, subject to these Terms.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                '3. Intellectual Property Rights',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'You acknowledge that all intellectual property rights relating to the App belong to us. You do not acquire any rights, title or interest in or to the App except as expressly set out in these Terms.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                '4. Use of Data',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'The App may collect and use data related to calories, heart rate, and physical activity to predict the optimal time for blood donation. Your use of such data will be governed by our Privacy Policy.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                '5. Disclaimer',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'The App is provided "as is" and "as available". We do not provide any warranties regarding the accuracy, reliability, or availability of the App or its services. Your use of the App is at your own risk.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                '6. Modifications and Termination',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'We reserve the right to modify, suspend, or terminate the App or any part of it without prior notice. We do not guarantee that the App will always be available or supported.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                '7. Governing Law and Jurisdiction',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'These Terms are governed by the laws of [insert your country or state]. Any disputes arising out of or in connection with these Terms will be exclusively resolved by the competent courts of [insert your jurisdiction].',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                '8. Contact Us',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'If you have any questions or concerns regarding these Terms or the use of the App, please contact us at [insert email address] or write to us at [insert postal address].',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
