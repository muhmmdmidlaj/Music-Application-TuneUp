import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_one_tuneup/widgets/play_list_scroll.dart';

class LibreryPage extends StatefulWidget {
  const LibreryPage({super.key});

  @override
  State<LibreryPage> createState() => _LibreryPageState();
}

class _LibreryPageState extends State<LibreryPage> {
  @override
  Widget build(BuildContext context) {
    // final double screenHight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      appBar: AppBar(
        title: Text(
          'All Librery',
          style: GoogleFonts.orbitron(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            ScrollPlay(),
          ],
        ),
      ),
    );
  }
}
