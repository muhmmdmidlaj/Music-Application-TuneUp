import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:project_one_tuneup/DB/functions/function_mostly.dart';
import 'package:project_one_tuneup/DB/functions/function_recently.dart';
import 'package:project_one_tuneup/settings/about.dart';
import 'package:project_one_tuneup/settings/help.dart';
import 'package:project_one_tuneup/settings/privacy_policy.dart';
import 'package:project_one_tuneup/settings/terms_conditions.dart';
import 'package:sizer/sizer.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
        leading: const Icon(Icons.settings),
        title: Text(
          'Settings',
          style: GoogleFonts.orbitron(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.edit_document,
                color: Colors.grey.shade500,
              ),
              title: Text(
                'Terms And Conditions',
                style: GoogleFonts.orbitron(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right_outlined,
                color: Colors.grey.shade500,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsAndConditions(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: Colors.grey.shade500,
              ),
              title: Text(
                'Privacy And Policy',
                style: GoogleFonts.orbitron(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right_outlined,
                color: Colors.grey.shade500,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyAndPolicy(),
                    ));
              },
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const About(),
                    ));
              },
              leading: Icon(
                Icons.info,
                color: Colors.grey.shade500,
              ),
              title: Text(
                'About TuneUp',
                style: GoogleFonts.orbitron(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right_outlined,
                color: Colors.grey.shade500,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.grey.shade500,
              ),
              title: Text(
                'Help & Services',
                style: GoogleFonts.orbitron(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right_outlined,
                color: Colors.grey.shade500,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Healp(),
                    ));
              },
            ),
            // ListTile(
            //   onTap: () {
            //     reset();
            //   },
            //   leading: Icon(
            //     Icons.restart_alt,
            //     color: Colors.grey.shade500,
            //   ),
            //   title: Text(
            //     'Reset App',
            //     style: GoogleFonts.orbitron(
            //       fontSize: 15,
            //       color: Colors.grey.shade500,
            //       fontWeight: FontWeight.w300,
            //     ),
            //   ),
            //   trailing: Icon(
            //     Icons.chevron_right_outlined,
            //     color: Colors.grey.shade500,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// Future<void> reset() async {
//   final mostlyDB = await Hive.box('mostlyplayeddb');
//   mostlyDB.clear();
//   final recentdatabase = Hive.box('recenlylistnotifier');
//   recentdatabase.clear();

//   Recentfunctions.recenlylistnotifier.value.clear();
//   MostlyplayedDb.mostlyplayednotifier.value.clear();
// }
