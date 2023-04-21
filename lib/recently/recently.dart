import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:project_one_tuneup/DB/functions/function_mostly.dart';
import 'package:project_one_tuneup/DB/functions/function_recently.dart';
import 'package:project_one_tuneup/recently/recently_play.dart';

class RecentlyPage extends StatefulWidget {
  const RecentlyPage({super.key});

  @override
  State<RecentlyPage> createState() => _RecentlyPageState();
}

class _RecentlyPageState extends State<RecentlyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
        title: Text(
          'Recently Played',
          style: GoogleFonts.orbitron(
            color: Colors.grey,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      body: const SafeArea(child: Recentlyplayedlist()),
    );
  }
}
