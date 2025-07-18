import 'package:flutter/material.dart';

class AnonymousScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderContainer(),
            SizedBox(height: size.height * 0.05),
            const QuestionText(),
            SizedBox(height: size.height * 0.05),
            OptionButton(text: 'Yes Please', width: size.width * 0.8),
            SizedBox(height: size.height * 0.02),
            OptionButton(
              text: 'No, I prefer to Provide Details',
              width: size.width * 0.8,
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
    );
  }
}

class QuestionText extends StatelessWidget {
  const QuestionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
      child: const Text(
        'Do you wish to stay Anonymously?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const OptionButton({
    super.key,
    required this.text,
    required this.width,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: const Color(0xFF7BA7D7),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFFCCD8DD)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
