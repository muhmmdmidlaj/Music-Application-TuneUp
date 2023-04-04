import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class Healp extends StatelessWidget {
  const Healp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
        title: Text(
          'Healp & Services',
          style: GoogleFonts.orbitron(),
        ),
      ),
      body: SafeArea(
          child: Center(
              child: Text(
        'Contact-\n muhammedmidlaj@gmail.com',
        style: GoogleFonts.orbitron(color: Colors.grey),
      ))),
    );
  }
}
