import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_one_tuneup/favorite/favroit.dart';
import 'package:project_one_tuneup/mostly/mostly.dart';
import 'package:project_one_tuneup/songlist/all_songs.dart';
import 'package:project_one_tuneup/playlist/play_list.dart';

class ScrollPlay extends StatefulWidget {
  const ScrollPlay({super.key});

  @override
  State<ScrollPlay> createState() => _ScrollPlayState();
}

class _ScrollPlayState extends State<ScrollPlay> {
  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHight / 4.5,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavroiteScreen(),
                  ),
                );
              },
              child: Container(
                height: screenHight / 5,
                width: screenWidth / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(27, 158, 158, 158),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/images.jpeg',
                      width: screenWidth / 2,
                      height: screenHight / 6.8,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Favorite',
                      style: GoogleFonts.orbitron(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayList(),
                  ),
                );
              },
              child: Container(
                height: screenHight / 5,
                width: screenWidth / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(27, 158, 158, 158),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/960x0.jpg',
                      width: screenWidth / 2,
                      height: screenHight / 6.8,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Play List',
                      style: GoogleFonts.orbitron(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Mostlyplayedscreen()));
              },
              child: Container(
                height: screenHight / 5,
                width: screenWidth / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(27, 158, 158, 158),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/suku.jpg',
                      width: screenWidth / 2,
                      height: screenHight / 6.8,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Mostly Played',
                      style: GoogleFonts.orbitron(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
