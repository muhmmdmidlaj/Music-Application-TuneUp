import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_one_tuneup/model/model.dart';
import 'package:project_one_tuneup/provider/provider.dart';
import 'package:project_one_tuneup/splash.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (!Hive.isAdapterRegistered(PlayModelAdapter().typeId)) {
    Hive.registerAdapter(PlayModelAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox<int>('favoriteDb');
  await Hive.openBox<PlayModel>('playlistDB');

  runApp(ChangeNotifierProvider(
      create: (context) => Songprovider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TuneUp',
      home: Splash(),
    );
  }
}
