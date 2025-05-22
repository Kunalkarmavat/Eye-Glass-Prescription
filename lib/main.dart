import 'package:eye_glass/screens/final_summary_screen.dart';
import 'package:eye_glass/screens/lens_info_screen.dart';
import 'package:eye_glass/screens/personal_info_screen.dart';
import 'package:eye_glass/screens/home_screen.dart';
import 'package:eye_glass/providers/prescription_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrescriptionProvider()),

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
        '/home': (context) => const HomeScreen(),
        '/form': (context) => const PersonalInfoScreen(),
        '/form2': (context) => const LensInfoScreen(),
        '/summary': (context) => const FinalSummaryScreen(),
      },
    );
  }
}
