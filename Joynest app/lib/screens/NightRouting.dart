import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NightRouting extends StatefulWidget {
  @override
  _NightRoutingState createState() => _NightRoutingState();
}

class _NightRoutingState extends State<NightRouting> {
  String dayOfWeek = DateFormat('EEEE').format(DateTime.now());
  Map<String, List<Map<String, String>>> routines = {
    'Monday': [
      {
        'title': 'Warm Bath',
        'description': 'Take a warm bath to relax your muscles.',
        'image': 'lib/assets/m2.png'
      },
      {
        'title': 'Gentle Stretching',
        'description': 'Do light stretches to ease tension.',
        'image': 'lib/assets/stretching.png'
      },
      {
        'title': 'Breathing Exercise',
        'description': 'Practice deep breathing to calm your mind.',
        'image': 'lib/assets/deep_breathing.png'
      },
    ],
    'Tuesday': [
      {
        'title': 'Reading',
        'description': 'Read a calming book before sleep.',
        'image': 'lib/assets/reading.png'
      },
      {
        'title': 'Chamomile Tea',
        'description': 'Drink a warm cup of chamomile tea.',
        'image': 'lib/assets/tea.png'
      },
      {
        'title': 'Soft Music',
        'description': 'Listen to soft and relaxing music.',
        'image': 'lib/assets/music.png'
      },
    ],
    'Wednesday': [
      {
        'title': 'Aromatherapy',
        'description': 'Use lavender essential oil for relaxation.',
        'image': 'lib/assets/aromatherapy.png'
      },
      {
        'title': 'Mindfulness',
        'description': 'Spend a few minutes practicing mindfulness.',
        'image': 'lib/assets/mindfulness.png'
      },
      {
        'title': 'Candle Meditation',
        'description': 'Gaze at a candle flame to focus and relax.',
        'image': 'lib/assets/candle.png'
      },
    ],
    'Thursday': [
      {
        'title': 'Journaling',
        'description': 'Write down positive thoughts before bed.',
        'image': 'lib/assets/journaling.png'
      },
      {
        'title': 'Progressive Relaxation',
        'description': 'Tense and relax each muscle group.',
        'image': 'lib/assets/relaxation.png'
      },
      {
        'title': 'Gratitude Reflection',
        'description': 'Reflect on three positive moments of your day.',
        'image': 'lib/assets/gratitude.png'
      },
    ],
    'Friday': [
      {
        'title': 'No Screens',
        'description': 'Avoid screens 30 minutes before bed.',
        'image': 'lib/assets/no_screens.png'
      },
      {
        'title': 'Guided Meditation',
        'description': 'Follow a guided sleep meditation.',
        'image': 'lib/assets/meditation.png'
      },
      {
        'title': 'Comfortable Bedding',
        'description': 'Ensure your bedding is clean and comfortable.',
        'image': 'lib/assets/bed.png'
      },
    ],
    'Saturday': [
      {
        'title': 'Slow Breathing',
        'description': 'Inhale deeply and exhale slowly for relaxation.',
        'image': 'lib/assets/breathing.png'
      },
      {
        'title': 'Positive Affirmations',
        'description': 'Say positive affirmations to yourself.',
        'image': 'lib/assets/affirmations.png'
      },
      {
        'title': 'Relaxing Podcast',
        'description': 'Listen to a relaxing or sleep-inducing podcast.',
        'image': 'lib/assets/podcast.png'
      },
    ],
    'Sunday': [
      {
        'title': 'Visualization',
        'description': 'Visualize a peaceful and happy place.',
        'image': 'lib/assets/visualization.png'
      },
      {
        'title': 'Stretching',
        'description': 'Do light stretching for better sleep.',
        'image': 'lib/assets/stretching.png'
      },
      {
        'title': 'Comforting Routine',
        'description': 'Follow a consistent bedtime routine.',
        'image': 'lib/assets/routine.png'
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
                      'Night Routine',
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
                    top: 820, // Adjusted position for the button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NightRouting()), // Navigate to NightRouting
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
