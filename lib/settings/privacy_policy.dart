import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

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
            "1 -\tThe app collects and stores user data only for the purpose of providing the service, such as music playback and preferences.\n 2-\t User data will not be shared with third-party advertisers or marketers without explicit consent.\n 3-\tThe app may use cookies and other tracking technologies to personalize the user experience.\n 4-\tUsers have the right to access, modify, or delete their personal data. \n 5-\tThe app may disclose user data if required by law or to protect its own legal interests.",
            style: GoogleFonts.orbitron(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
