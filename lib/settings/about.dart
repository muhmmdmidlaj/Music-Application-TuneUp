import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
        title: Text(
          'About TuneUp',
          style: GoogleFonts.orbitron(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "TuneUp music app is a mobile application that allows users to download and store music on their device for offline playback. With an offline music app, users can listen to their favorite songs and playlists without an internet connection, making it ideal for situations where internet connectivity is limited or unavailable. These apps typically offer a wide variety of music genres and artists, and often allow users to create and customize their own playlists. Some offline music apps may also offer additional features such as lyrics, album artwork, and equalizer settings to enhance the listening experience.",
          style: GoogleFonts.orbitron(color: Colors.grey),
        ),
      ),
    );
  }
}
