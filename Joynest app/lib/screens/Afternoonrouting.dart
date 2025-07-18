import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'NightRouting.dart';

class AfternoonRouting extends StatefulWidget {
  @override
  _AfternoonRoutingState createState() => _AfternoonRoutingState();
}

class _AfternoonRoutingState extends State<AfternoonRouting> {
  String dayOfWeek = DateFormat('EEEE').format(DateTime.now());
  Map<String, List<Map<String, String>>> routines = {
    'Monday': [
      {
        'title': 'Mindful Walking',
        'description': 'Take a short mindful walk, focusing on your breath.',
        'image': 'lib/assets/m3.png'
      },
      {
        'title': 'Gratitude Practice',
        'description': 'Write down three things you are grateful for.',
        'image': 'lib/assets/m2.png'
      },
      {
        'title': 'Music Therapy',
        'description': 'Listen to calming or uplifting music.',
        'image': 'lib/assets/music.png'
      },
    ],
    'Tuesday': [
      {
        'title': 'Yoga',
        'description': 'Engage in a 15-minute yoga session.',
        'image': 'lib/assets/yoga.png'
      },
      {
        'title': 'Creative Activity',
        'description': 'Paint, draw, or engage in another creative outlet.',
        'image': 'lib/assets/creative_activity.png'
      },
      {
        'title': 'Healthy Snack',
        'description': 'Prepare and enjoy a nutritious snack.',
        'image': 'lib/assets/healthy_snack.png'
      },
    ],
    'Wednesday': [
      {
        'title': 'Meditation',
        'description': 'Practice a guided meditation for relaxation.',
        'image': 'lib/assets/meditation.png'
      },
      {
        'title': 'Reading',
        'description': 'Read a few pages of an inspiring book.',
        'image': 'lib/assets/reading.png'
      },
      {
        'title': 'Sunlight Exposure',
        'description': 'Spend time outside for fresh air and sunlight.',
        'image': 'lib/assets/sunlight.png'
      },
    ],
    'Thursday': [
      {
        'title': 'Journaling',
        'description': 'Write about your feelings and reflections.',
        'image': 'lib/assets/journaling.png'
      },
      {
        'title': 'Deep Breathing',
        'description': 'Practice deep breathing to relax.',
        'image': 'lib/assets/deep_breathing.png'
      },
      {
        'title': 'Stretching',
        'description': 'Do some gentle stretches to relieve tension.',
        'image': 'lib/assets/stretching.png'
      },
    ],
    'Friday': [
      {
        'title': 'Social Connection',
        'description': 'Call or message a friend or family member.',
        'image': 'lib/assets/social_connection.png'
      },
      {
        'title': 'Hydration',
        'description': 'Drink enough water to stay hydrated.',
        'image': 'lib/assets/hydration.png'
      },
      {
        'title': 'Positive Affirmations',
        'description': 'Repeat positive affirmations to yourself.',
        'image': 'lib/assets/affirmations.png'
      },
    ],
    'Saturday': [
      {
        'title': 'Exercise',
        'description': 'Do light physical activity like a walk or workout.',
        'image': 'lib/assets/exercise.png'
      },
      {
        'title': 'Nature Connection',
        'description': 'Spend time in nature to feel refreshed.',
        'image': 'lib/assets/nature.png'
      },
      {
        'title': 'Healthy Meal',
        'description': 'Prepare and eat a balanced, nutritious meal.',
        'image': 'lib/assets/healthy_meal.png'
      },
    ],
    'Sunday': [
      {
        'title': 'Self-Care',
        'description': 'Engage in a self-care routine you enjoy.',
        'image': 'lib/assets/self_care.png'
      },
      {
        'title': 'Laughing Therapy',
        'description': 'Watch or listen to something that makes you laugh.',
        'image': 'lib/assets/laughing_therapy.png'
      },
      {
        'title': 'Reflection',
        'description':
            'Reflect on the past week and set intentions for the next.',
        'image': 'lib/assets/reflection.png'
      },
    ],
  };

  List<bool> completed = [false, false, false];
  final List<Color> cardColors = [
    Color(0xFFFAD6D6),
    Color(0xFFD6FAD6),
    Color(0xFFD6D6FA)
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> selectedActivities =
        routines[dayOfWeek] ?? routines['Monday']!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 412,
              height: 917,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 412,
                      height: 78,
                      decoration: BoxDecoration(color: Color(0xFFCCD8DD)),
                    ),
                  ),
                  Positioned(
                    left: 105,
                    top: 89,
                    child: Text(
                      'Afternoon Routine',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  for (int i = 0; i < selectedActivities.length; i++) ...[
                    Positioned(
                      left: 30,
                      top: 150 + (i * 200),
                      child: Row(
                        children: [
                          Checkbox(
                            value: completed[i],
                            onChanged: (bool? value) {
                              setState(() {
                                completed[i] = value ?? false;
                              });
                            },
                          ),
                          Text(
                            selectedActivities[i]['title']!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              decoration: completed[i]
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 195 + (i * 200),
                      child: Container(
                        width: 352,
                        height: 135,
                        decoration: BoxDecoration(
                          color: cardColors[i % 3],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                selectedActivities[i]['image']!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectedActivities[i]['description']!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  Positioned(
                    left: 117,
                    top: 820,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NightRouting()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF88BDF5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 12),
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
