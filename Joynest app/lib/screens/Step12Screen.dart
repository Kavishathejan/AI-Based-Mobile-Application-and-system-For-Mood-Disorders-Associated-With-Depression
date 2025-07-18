import 'package:flutter/material.dart';
import 'Gadsurvey2.dart';

class Step12Screen extends StatefulWidget {
  @override
  _Step12ScreenState createState() => _Step12ScreenState();
}

class _Step12ScreenState extends State<Step12Screen> {
  // Variable to hold the selected option
  String selectedWay = "Yes"; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3DDE2),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "GAD Survey",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Answer the following questions to help us understand your depression levels.",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Step 12 of 12",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Do you suffer from sleep problem?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    RadioListTile<String>(
                      value: "Yes",
                      groupValue: selectedWay,
                      onChanged: (value) {
                        setState(() {
                          selectedWay = value!;
                        });
                      },
                      title: Text("Yes"),
                      activeColor: Colors.teal[700],
                    ),
                    RadioListTile<String>(
                      value: "No",
                      groupValue: selectedWay,
                      onChanged: (value) {
                        setState(() {
                          selectedWay = value!;
                        });
                      },
                      title: Text("No"),
                      activeColor: Colors.teal[700],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Go back
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            side: BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal[700],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Gadsurvey2(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF88BDF5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
