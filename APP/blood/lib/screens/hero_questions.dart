import 'package:flutter/material.dart';

class DoubtsDonation extends StatelessWidget {
  const DoubtsDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 175, 175), // Sfondo azzurro
      appBar: AppBar(
        centerTitle: true, //centro titolo nell'appbar
        title: Text('Q&A', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 240, 175, 175),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Hero(
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
                    image: AssetImage('assets/images/hero1.jpg'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0), // Spazio tra la foto e il container bianco
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0), // Margini orizzontali
                padding: EdgeInsets.all(16.0), // Padding interno
                decoration: BoxDecoration(
                  color: Colors.white, // Sfondo bianco per il container
                  borderRadius: BorderRadius.circular(15.0), // Bordo arrotondato
                ),
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      children: [
                        TextSpan(
                          text: 'How safe is blood donation?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Making a blood donation is very safe, and most donors have a very good donation experience. There is no risk of catching a disease as every kit (needles and collection bag) is sterile and used only once.\n\n',
                        ),
                        TextSpan(
                          text: 'What should donors eat on the day of donation?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Drink plenty of non-alcoholic fluids (water, sports drinks, juice etc.) as you lose fluid when you donate. Make sure you also eat something that day and don\'t come on an empty stomach.\n\n',
                        ),
                        TextSpan(
                          text: 'How soon before a donation should you eat?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'We recommend you have something to eat at least 4 hours before you donate to ensure a good donation experience.\n\n',
                        ),
                        TextSpan(
                          text: 'Is it OK to exercise on the morning of my donation?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Yes - provided you make sure to rehydrate afterwards.\n\n',
                        ),
                        TextSpan(
                          text: 'Can a person donate if they have a cold or allergies?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'If you have a mild cold, sneezing, or cough, we would ask you to postpone your donations until you are feeling 100%. That is to ensure both your safety and that of the recipient.\n\n',
                        ),
                        TextSpan(
                          text: 'Is there a time when it would not be good to donate?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'It\'s not a good idea to donate if you are hungover as you may be dehydrated and could end up feeling light-headed afterwards.\n\n',
                        ),
                
                        
                        TextSpan(
                          text: 'Does donating blood affect your athletic performance?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'If you are a recreational athlete, you should be able to continue your activities the next day, but we discourage you from doing any rigorous exercise following your donation. If you are a competitive athlete, we recommend not donating in the few weeks leading up to an event or race.\n\n',
                        ),
                        TextSpan(
                          text: 'Are there any other suggestions to improve the donation experience?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Bring a book or music to listen to keep yourself entertained. We have free WiFi at our donor centres for you to use during your appointment.\n\n',
                        ),
                        TextSpan(
                          text: 'What about after the donor leaves the Donor Centre or blood drive, what should they do?\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'For the rest of the day, drink plenty of fluids and avoid strenuous activities. You can remove the bandage once it has stopped bleeding.\n',
                        ),
                      ],
                    ),
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
