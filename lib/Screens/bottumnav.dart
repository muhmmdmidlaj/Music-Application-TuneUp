import 'package:flutter/material.dart';
import 'package:project_one_tuneup/Screens/screen_one.dart';
import 'package:project_one_tuneup/controller/getallsongs_controller.dart';
import 'package:project_one_tuneup/minipleyer/mini_pleyer.dart';
import 'package:project_one_tuneup/recently/recently.dart';
import 'package:project_one_tuneup/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomnavindexnum = 0;
  List botomnav = const [ScreenOne(), RecentlyPage(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          botomnav[bottomnavindexnum],
          Positioned(
              bottom: 0,
              left: 0,
              right: 10,
              child: Column(
                children: [
                  Getallsongs.audioPlayer.currentIndex != null ||
                          Getallsongs.audioPlayer.currentIndex == 0
                      ? const Miniplayers()
                      : Container()
                ],
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        elevation: 30.5,
        mouseCursor: MaterialStateMouseCursor.clickable,
        backgroundColor: const Color.fromARGB(255, 14, 21, 27),
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 26, 38, 61),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: bottomnavindexnum,
        onTap: (int index) {
          setState(() {
            bottomnavindexnum = index;
          });
        },
      ),
    );
  }
}
