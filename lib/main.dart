import 'package:eye_glass/Views/Final_Summary.dart';
import 'package:eye_glass/Views/Lens_Info.dart';
import 'package:eye_glass/Views/Personal_Info.dart';
import 'package:eye_glass/Views/home_%20screens.dart';
import 'package:eye_glass/Provider/lens_provider.dart';
import 'package:eye_glass/Provider/prescription_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrescriptionProvider()),
        ChangeNotifierProvider(create: (_) => LensProvider()),

        // Add other providers below as needed
        // ChangeNotifierProvider(create: (_) => AnotherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prescription App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) =>  Home_Screen(),
        '/form': (context) => const Personal_Info(),
        '/form2': (context) => const LensInfo(),
        '/summary': (context) => const FinalSummary(),
      },
    );
  }
}
