import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/mostly/mostly_paylist.dart';

class Mostlyplayedscreen extends StatefulWidget {
  const Mostlyplayedscreen({super.key});

  @override
  State<Mostlyplayedscreen> createState() => _MostlyplayedscreenState();
}

class _MostlyplayedscreenState extends State<Mostlyplayedscreen> {
  OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> mostly = [];
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
          'Mostly Play',
          style: GoogleFonts.orbitron(color: Colors.grey),
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: 790,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [Expanded(child: Mostlyplayedlist())],
        ),
      )),
    );
  }
}
