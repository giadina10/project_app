import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood/provider/FeaturesProvider.dart'; // Adjust the import path as necessary

class ActivityLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Set the height here
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 186, 235, 232),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          centerTitle: true, //titolo centrale
        title: Text('Activity Level',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
      
      ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255), // Updated background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FeaturesProvider>(
          builder: (context, featuresProvider, child) {
            return _buildContent(featuresProvider.activityLevel);
          },
        ),
      ),
    );
  }

  Widget _buildContent(double activityLevel) {
    String advice;
    List<TextSpan> descriptionTextSpans;

    if (activityLevel <= 2) {
      advice = 'Low Activity Level';
      descriptionTextSpans = [
        TextSpan(text: 'You have a low activity level. Incorporating more physical activities into your daily routine can significantly enhance your overall health and well-being. Regular physical activity is not only crucial for maintaining a healthy weight and cardiovascular health but also plays a vital role in blood donation.\n\n'),
        TextSpan(text: 'Physical activity helps improve circulation, making your veins easier to find during the donation process', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ', which can make the donation experience smoother and more efficient. Additionally, a more active lifestyle can enhance your mood and energy levels, which can help you recover more quickly after donating blood.\n\n'),
        TextSpan(text: 'Here are some suggestions to help increase your activity level:\n', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '- Start with small, manageable changes like taking short walks during your breaks or choosing stairs over elevators.\n- Consider incorporating activities that you enjoy, such as dancing, swimming, or cycling, to make it more fun and sustainable.\n- Aim for at least 30 minutes of moderate-intensity activity on most days of the week. This could be broken down into shorter sessions if that fits better into your schedule.\n- Joining a fitness class or finding a workout buddy can provide motivation and make the activity more enjoyable.\n\n'),
        TextSpan(text: 'Remember, even a small increase in your daily physical activity can have significant health benefits and improve your blood donation experience.', style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
      ];
    } else if (activityLevel <= 4) {
      advice = 'Moderate Activity Level';
      descriptionTextSpans = [
        TextSpan(text: 'You have a moderate activity level, which is a great foundation for maintaining a healthy lifestyle. Being moderately active helps keep your heart, lungs, and muscles in good condition, which is beneficial for overall health and for blood donation.\n\n'),
        TextSpan(text: 'Maintaining a moderate activity level can improve blood flow and circulation', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ', making your veins more accessible and the donation process easier. It also helps in maintaining a healthy weight and reducing the risk of chronic diseases, which can positively affect your eligibility and readiness for blood donation.\n\n'),
        TextSpan(text: 'Here are some ways to maintain or even boost your activity level:\n', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '- Mix up your exercise routine to include both aerobic exercises (like walking, running, or swimming) and strength training (like lifting weights or bodyweight exercises).\n- Set realistic goals to gradually increase the intensity and duration of your workouts.\n- Make physical activity a part of your daily routine, such as walking or biking to work, gardening, or doing household chores.\n- Stay hydrated and maintain a balanced diet to support your physical activities and overall health.\n\n'),
        TextSpan(text: 'By staying moderately active, you are not only supporting your health but also contributing to a smoother and more efficient blood donation process.', style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
      ];
    } else if (activityLevel <= 6) {
      advice = 'Active';
      descriptionTextSpans = [
        TextSpan(text: 'You are quite active, which is excellent for your overall health and well-being. Regular physical activity helps maintain a strong cardiovascular system, healthy weight, and robust immune system, all of which are important when considering blood donation.\n\n'),
        TextSpan(text: 'Being active enhances your blood flow and circulation', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ', making your veins easier to locate during the donation process and potentially making the experience quicker and more comfortable. Additionally, a well-maintained level of physical activity can speed up your recovery after donating blood.\n\n'),
        TextSpan(text: 'Here are some tips to continue benefiting from your active lifestyle:\n', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '- Ensure a balanced routine that includes cardiovascular exercises, strength training, and flexibility exercises to maintain overall fitness.\n- Listen to your body and allow time for rest and recovery to prevent overtraining and injuries.\n- Stay hydrated and consume a nutrient-rich diet to fuel your activities and support your health.\n- Monitor your health and energy levels, adjusting your activity levels as needed to maintain balance.\n\n'),
        TextSpan(text: 'Your commitment to staying active not only benefits your personal health but also makes you a valuable and efficient blood donor.', style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
      ];
    } else if (activityLevel <= 8) {
      advice = 'Very Active';
      descriptionTextSpans = [
        TextSpan(text: 'You have a very high activity level, which is highly beneficial for your health. A very active lifestyle supports a strong cardiovascular system, optimal body weight, and overall physical fitness, all of which are advantageous when donating blood.\n\n'),
        TextSpan(text: 'High activity levels can improve your blood flow and circulation', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ', facilitating the blood donation process. Moreover, being very active can lead to quicker recovery times post-donation and generally makes you feel more energized and healthier.\n\n'),
        TextSpan(text: 'To continue reaping the benefits of your active lifestyle, consider the following:\n', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '- Balance your exercise routine with a variety of activities, including aerobic exercises, strength training, and flexibility workouts.\n- Pay attention to your body\'s signals and ensure you get adequate rest and recovery to avoid overtraining and fatigue.\n- Maintain a balanced diet rich in essential nutrients to support your high level of activity and overall health.\n- Stay hydrated, especially before and after workouts, to ensure optimal performance and recovery.\n\n'),
        TextSpan(text: 'Your dedication to maintaining a very active lifestyle is commendable and significantly enhances your efficiency and effectiveness as a blood donor.', style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
      ];
    } else {
      advice = 'Extremely Active';
      descriptionTextSpans = [
        TextSpan(text: 'You are extremely active, which is outstanding for your health. An extremely active lifestyle contributes to exceptional cardiovascular health, muscular strength, and overall physical and mental well-being. This level of activity is particularly advantageous for blood donation.\n\n'),
        TextSpan(text: 'With such high activity levels, your blood flow and circulation are likely very efficient', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ', making the donation process smoother. Additionally, your physical fitness can lead to quicker recovery after donating blood, and your overall health is well-supported by your active lifestyle.\n\n'),
        TextSpan(text: 'To maintain and optimize the benefits of your extremely active lifestyle, consider the following:\n', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '- Ensure a well-rounded fitness regimen that includes cardio, strength training, and flexibility exercises to support comprehensive fitness.\n- Prioritize rest and recovery to avoid overtraining and burnout, allowing your body to repair and strengthen.\n- Follow a balanced, nutrient-rich diet to meet the high demands of your physical activities and to maintain your health.\n- Stay adequately hydrated to support your intense activity levels and overall well-being.\n\n'),
        TextSpan(text: 'Your high level of activity not only contributes to your personal health but also makes you an exceptional and resilient blood donor.', style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
      ];
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            advice,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto Serif',
            ),
          ),
          SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Roboto Serif',
              ),
              children: descriptionTextSpans,
            ),
          ),
        ],
      ),
    );
  }
}