import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood/provider/FeaturesProvider.dart'; // Adjust the import path as necessary

class ActivityLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Level'),
        backgroundColor: Color.fromARGB(255, 186, 235, 232), // Updated AppBar color
      ),
      backgroundColor: Color.fromARGB(255, 186, 235, 232), // Updated background color
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
    String description;

    if (activityLevel <= 2) {
      advice = 'Low Activity Level';
      description = '''
You have a low activity level. Incorporating more physical activities into your daily routine can significantly enhance your overall health and well-being. Regular physical activity is not only crucial for maintaining a healthy weight and cardiovascular health but also plays a vital role in blood donation.

Physical activity helps improve circulation, making your veins easier to find during the donation process, which can make the donation experience smoother and more efficient. Additionally, a more active lifestyle can enhance your mood and energy levels, which can help you recover more quickly after donating blood.

Here are some suggestions to help increase your activity level:
- Start with small, manageable changes like taking short walks during your breaks or choosing stairs over elevators.
- Consider incorporating activities that you enjoy, such as dancing, swimming, or cycling, to make it more fun and sustainable.
- Aim for at least 30 minutes of moderate-intensity activity on most days of the week. This could be broken down into shorter sessions if that fits better into your schedule.
- Joining a fitness class or finding a workout buddy can provide motivation and make the activity more enjoyable.

Remember, even a small increase in your daily physical activity can have significant health benefits and improve your blood donation experience.
      ''';
    } else if (activityLevel <= 4) {
      advice = 'Moderate Activity Level';
      description = '''
You have a moderate activity level, which is a great foundation for maintaining a healthy lifestyle. Being moderately active helps keep your heart, lungs, and muscles in good condition, which is beneficial for overall health and for blood donation.

Maintaining a moderate activity level can improve blood flow and circulation, making your veins more accessible and the donation process easier. It also helps in maintaining a healthy weight and reducing the risk of chronic diseases, which can positively affect your eligibility and readiness for blood donation.

Here are some ways to maintain or even boost your activity level:
- Mix up your exercise routine to include both aerobic exercises (like walking, running, or swimming) and strength training (like lifting weights or bodyweight exercises).
- Set realistic goals to gradually increase the intensity and duration of your workouts.
- Make physical activity a part of your daily routine, such as walking or biking to work, gardening, or doing household chores.
- Stay hydrated and maintain a balanced diet to support your physical activities and overall health.

By staying moderately active, you are not only supporting your health but also contributing to a smoother and more efficient blood donation process.
      ''';
    } else if (activityLevel <= 6) {
      advice = 'Active';
      description = '''
You are quite active, which is excellent for your overall health and well-being. Regular physical activity helps maintain a strong cardiovascular system, healthy weight, and robust immune system, all of which are important when considering blood donation.

Being active enhances your blood flow and circulation, making your veins easier to locate during the donation process and potentially making the experience quicker and more comfortable. Additionally, a well-maintained level of physical activity can speed up your recovery after donating blood.

Here are some tips to continue benefiting from your active lifestyle:
- Ensure a balanced routine that includes cardiovascular exercises, strength training, and flexibility exercises to maintain overall fitness.
- Listen to your body and allow time for rest and recovery to prevent overtraining and injuries.
- Stay hydrated and consume a nutrient-rich diet to fuel your activities and support your health.
- Monitor your health and energy levels, adjusting your activity levels as needed to maintain balance.

Your commitment to staying active not only benefits your personal health but also makes you a valuable and efficient blood donor.
      ''';
    } else if (activityLevel <= 8) {
      advice = 'Very Active';
      description = '''
You have a very high activity level, which is highly beneficial for your health. A very active lifestyle supports a strong cardiovascular system, optimal body weight, and overall physical fitness, all of which are advantageous when donating blood.

High activity levels can improve your blood flow and circulation, facilitating the blood donation process. Moreover, being very active can lead to quicker recovery times post-donation and generally makes you feel more energized and healthier.

To continue reaping the benefits of your active lifestyle, consider the following:
- Balance your exercise routine with a variety of activities, including aerobic exercises, strength training, and flexibility workouts.
- Pay attention to your body's signals and ensure you get adequate rest and recovery to avoid overtraining and fatigue.
- Maintain a balanced diet rich in essential nutrients to support your high level of activity and overall health.
- Stay hydrated, especially before and after workouts, to ensure optimal performance and recovery.

Your dedication to maintaining a very active lifestyle is commendable and significantly enhances your efficiency and effectiveness as a blood donor.
      ''';
    } else {
      advice = 'Extremely Active';
      description = '''
You are extremely active, which is outstanding for your health. An extremely active lifestyle contributes to exceptional cardiovascular health, muscular strength, and overall physical and mental well-being. This level of activity is particularly advantageous for blood donation.

With such high activity levels, your blood flow and circulation are likely very efficient, making the donation process smoother. Additionally, your physical fitness can lead to quicker recovery after donating blood, and your overall health is well-supported by your active lifestyle.

To maintain and optimize the benefits of your extremely active lifestyle, consider the following:
- Ensure a well-rounded fitness regimen that includes cardio, strength training, and flexibility exercises to support comprehensive fitness.
- Prioritize rest and recovery to avoid overtraining and burnout, allowing your body to repair and strengthen.
- Follow a balanced, nutrient-rich diet to meet the high demands of your physical activities and to maintain your health.
- Stay adequately hydrated to support your intense activity levels and overall well-being.

Your high level of activity not only contributes to your personal health but also makes you an exceptional and resilient blood donor.
      ''';
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
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Serif',
            ),
          ),
        ],
      ),
    );
  }
}
