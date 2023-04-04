import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_one_tuneup/Screens/bottumnav.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      body: Stack(
        children: [
          Positioned(
            left: screenWidth / 3,
            top: screenHight / 10,
            child: Center(
              child: Text(
                'TuneUp',
                style: GoogleFonts.orbitron(
                  fontSize: 27,
                  color: Colors.orange,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHight * .16,
            left: screenWidth * .10,
            right: screenWidth * .10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Center(
                child: Text(
                  '"Listen to Your Beat."',
                  style: GoogleFonts.orbitron(
                    fontSize: screenWidth * 0.065,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHight / 3.5,
            left: screenWidth / 50,
            right: screenWidth / 50,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 40, 35, 0),
              child: Center(
                child: Text(
                  'Listen Your Latest Favourite Music From Our Collection',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.orbitron(
                    fontSize: screenWidth * .04,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHight / 2.4,
            left: screenWidth / 3,
            right: screenWidth / 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    shadowColor: const Color.fromARGB(255, 230, 168, 11),
                    backgroundColor: const Color.fromARGB(255, 147, 32, 159),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Text('Lets Go..'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHight / 1.7,
            left: screenWidth / 20,
            right: screenWidth / 20,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
              child: SizedBox(
                height: screenHight * 6,
                width: screenWidth * 7,
                child: Lottie.network(
                    'https://assets7.lottiefiles.com/packages/lf20_VE06RZ.json'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
