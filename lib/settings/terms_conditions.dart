import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.orbitron(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "1 -\tThe 'TuneUp' music app is for personal use only and cannot be used for commercial purposes.\n 2-\t Users must comply with all applicable copyright laws and obtain necessary permissions for any copyrighted content they upload to the app.\n 3-\tThe app does not guarantee the accuracy, completeness, or reliability of any content uploaded by users.\n 4-\t The app may periodically require updates or maintenance that may temporarily disrupt service. \n 5-\t By using the app, users agree to indemnify and hold harmless the app's developers from any claims or damages arising from their use of the app",
            style: GoogleFonts.orbitron(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
