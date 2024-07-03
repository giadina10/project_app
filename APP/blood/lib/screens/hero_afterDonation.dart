import 'package:flutter/material.dart';

class Postdonation extends StatelessWidget {
  const Postdonation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 175, 175),
      appBar: AppBar(
        title: Text('After the donation',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 240, 175, 175),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: 'information',
              child: Container(
                width: 300,
                height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/hero2.jpg'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ExpansionTile(
                        title: Text(
                          "In the next 1-2 hours...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "• Make sure to appropriately rest and avoid excessive movement of your arms\n"
                              "• Avoid carrying heavy loads on the arm used for your donation\n"
                              "• Drink at least 2 glasses of water (approx. 500mL), then continue to drink plenty of fluids throughout the day\n"
                              "• Avoid drinking alcohol or smoking as this may lead to lightheadedness and fainting",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          "In the next 6 hours...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "• Do not rush around or walk for long periods\n"
                              "• Do not stand for long periods\n"
                              "• Do not do any strenuous exercise (e.g. jogging, cycling, or going to the gym)\n"
                              "• Do not do any strenuous or hazardous occupational activities (e.g. lifting heavy loads)\n"
                              "• Do not have a hot shower or bath",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          "In the next 48 hours...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "Please call the nearest Emergency Room immediately and ask for a nurse if you:\n"
                              "• Feel unwell\n"
                              "• Develop any infection, diarrhoea or other illness\n"
                              "• Remember medication or personal circumstances not mentioned at your donation interview\n"
                              "• After reading the 'Safe Blood Starts With You' pamphlet, reconsider your decision or think your blood should not be used for transfusion\n\n"
                              "There is no need to give a reason for withdrawing your donation if you do not wish to. If you wish to discuss the matter with one of our Medical or Nursing staff, please ask.\n\n"
                              "If you require urgent medical advice after hours, please contact your GP or see your local emergency department.",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          "In the event of bleeding or bruising...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "• In the unlikely instance of bleeding at the venepuncture site, apply direct pressure with a tissue and elevate your arm above your shoulder for 10 minutes.\n"
                              "• If severe bruising occurs at the venepuncture site, apply an ice pack wrapped in a towel. Please phone us on 0800 GIVE BLOOD if this happens as we need to record this event and may be able to give you helpful advice.\n"
                              "• If you are concerned, please seek medical advice directly.",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          "After 1 week...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "• Resume normal activities including strenuous exercise and heavy lifting\n"
                              "• Ensure the venepuncture site is healed and free of any discomfort or unusual symptoms\n"
                              "• Continue to monitor your health and report any persistent issues to your healthcare provider",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          "General post-donation guidelines...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "• Keep the venepuncture site clean and dry for 24 hours\n"
                              "• Avoid alcohol consumption for at least 24 hours\n"
                              "• Maintain a balanced diet and stay hydrated\n"
                              "• Follow any specific instructions provided by healthcare professionals",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          "Managing discomfort or side effects...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "• If you experience any discomfort at the venepuncture site (e.g., soreness, redness), apply a warm compress\n"
                              "• Take over-the-counter pain relievers as recommended by your healthcare provider\n"
                              "• Rest with your arm elevated to reduce swelling\n"
                              "• Contact healthcare professionals if symptoms persist or worsen",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
