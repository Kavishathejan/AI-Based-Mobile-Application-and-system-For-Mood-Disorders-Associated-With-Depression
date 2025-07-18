import 'package:flutter/material.dart';
import 'Step4Screen.dart';


class Step3screen extends StatefulWidget {
  @override
  _Step3screenState createState() => _Step3screenState();
}

class _Step3screenState extends State<Step3screen> {
  // Variable to hold the selected gender
  String? selectedGender = "Male"; // Default selection

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
            children: [
              SizedBox(height: 20),
              Text(
                "GAD survey",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Answer the following questions to help us understand your depression levels",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Container(
                height: 540,
                width: 341,
                padding: EdgeInsets.all(14),
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
                  children: [
                    Text(
                      "Step 3 of 12",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "What is your gender?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    RadioListTile<String>(
                      value: "Male",
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      title: Text("Male"),
                      activeColor: Colors.teal[700],
                    ),
                    RadioListTile<String>(
                      value: "Female",
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      title: Text("Female"),
                      activeColor: Colors.teal[700],
                    ),
                    RadioListTile<String>(
                      value: "Other",
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      title: Text("Other"),
                      activeColor: Colors.teal[700],
                    ),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigate back or previous screen
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            side: BorderSide(color: Colors.grey),
                            padding: EdgeInsets.symmetric(
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
      MaterialPageRoute(builder: (context) => Step4Screen()),
    );// Navigate to next step
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF88BDF5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Next",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    )
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
