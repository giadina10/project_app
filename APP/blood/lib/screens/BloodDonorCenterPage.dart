import 'package:flutter/material.dart';

class BloodDonorCenterPage extends StatelessWidget {
  BloodDonorCenterPage({Key? key}) : super(key: key);

  // Lista di centri di donazione del sangue in Italia
  final List<Map<String, String>> bloodDonationCenters = [
    {
      "name": "Centro Trasfusionale Policlinico di Milano",
      "location": "Milano",
      "email": "info@trasfusionalemilano.it"
    },
    {"name": "AVIS Firenze", "location": "Firenze", "email": "info@avisfirenze.it"},
    {
      "name": "Ospedale Papa Giovanni XXIII",
      "location": "Bergamo",
      "email": "info@ospedalebergamo.it"
    },
    {
      "name": "Policlinico Gemelli",
      "location": "Roma",
      "email": "info@poligemelliroma.it"
    },
    {
      "name": "Ospedale San Giovanni Bosco",
      "location": "Torino",
      "email": "info@ospedalebosco.it"
    },
    {
      "name": "Ospedale Maggiore di Bologna",
      "location": "Bologna",
      "email": "info@ospedalebologna.it"
    },
    {
      "name": "Ospedale Niguarda Ca' Granda",
      "location": "Milano",
      "email": "info@ospedaleniguarda.it"
    },
    {
      "name": "AOU Città della Salute e della Scienza di Torino",
      "location": "Torino",
      "email": "info@ospedaletorino.it"
    },
    {
      "name": "Ospedale Sant'Orsola-Malpighi",
      "location": "Bologna",
      "email": "info@santorsolabologna.it"
    },
    {
      "name": "Ospedale Policlinico San Martino",
      "location": "Genova",
      "email": "info@ospedalesanmartino.it"
    },
    {"name": "Ospedale Careggi", "location": "Firenze", "email": "info@careggifirenze.it"},
    {
      "name": "Ospedale Universitario Padova",
      "location": "Padova",
      "email": "info@ospedalepadova.it"
    },
    {
      "name": "Ospedale Mauriziano",
      "location": "Torino",
      "email": "info@ospedalemauriziano.it"
    },
    {
      "name": "Ospedale Civile di Brescia",
      "location": "Brescia",
      "email": "info@ospedalebrescia.it"
    },
    {
      "name": "Ospedale Santa Maria della Misericordia",
      "location": "Udine",
      "email": "info@santamariaudine.it"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Blood Donor Center'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const  Color.fromARGB(255, 186, 235, 232), // Sfondo azzurro
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var center in bloodDonationCenters)
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordo arrotondato
                    side: BorderSide(color: Colors.white, width: 1), // Contorno bianco
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white, // Sfondo bianco
                    child: ListTile(
                      title: Text(center["name"]!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(center["location"]!),
                          const SizedBox(height: 4),
                          Text(center["email"]!, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      onTap: () {
                        // Azioni da eseguire al cliccare su un centro (opzionale)
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
