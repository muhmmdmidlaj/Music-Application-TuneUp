import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_one_tuneup/Screens/home_Screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 10000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      body: Stack(
        children: [
          // Positioned(
          //   left: screenWidth / 20,
          //   right: screenWidth / 30,
          //   child: const Padding(
          //     padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
          //     child: Image(
          //       alignment: Alignment.center,
          //       image: AssetImage('assets/images/logo.png'),
          //       height: 100,
          //       width: 100,
          //     ),
          //   ),
          // ),
          Positioned(
            left: screenWidth / 3,
            top: screenHight * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
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
          // Positioned(
          //   top: screenHight / 5,
          //   left: screenWidth / 10,
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          //     child: Text(
          //       '"Listen to Your Beat."',
          //       style: GoogleFonts.orbitron(
          //         fontSize: 27,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            top: screenHight / 3.5,
            left: screenWidth / 50,
            right: screenWidth / 50,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 40, 35, 0),
              child: Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_wcfkpodg.json',
                      height: 200,
                      width: 200),
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: screenHight / 2.2,
          //   left: screenWidth / 2.5,
          //   child: const Padding(
          //     padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          //     child: SpinKitSpinningLines(
          //       color: Colors.orange,
          //       size: 50,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: screenHight / 1.7,
          //   left: screenWidth / 20,
          //   right: screenWidth / 30,
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
          //     child: Image(
          //       alignment: Alignment.center,
          //       image: const AssetImage('assets/images/gold-music-png-19.png'),
          //       width: screenWidth,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
