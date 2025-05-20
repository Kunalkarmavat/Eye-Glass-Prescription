import 'package:eye_glass/models/prescription.dart';
import 'package:eye_glass/providers/prescription_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PrescriptionProvider>(context, listen: false)
        .getAllPrescriptions();
  }

  @override
  Widget build(BuildContext context) {
    final PrescriptionProvider provider = context.watch<PrescriptionProvider>();
    Color myColor = const Color.fromARGB(255, 242, 242, 253);

    return Scaffold(
      backgroundColor: myColor,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(72, 76, 224, 1)),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: myColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.abc_outlined),
            Text(
              'SEE ◉-◉ \nCLAEARLY ',
              textAlign: TextAlign.left,
              style: GoogleFonts.inter(
                fontSize: 54,
                fontWeight: FontWeight.w900,
                height: 1.2,
                color: Colors.black,
              ),
            ),
            Text(
              'SAVE EASILY.',
              textAlign: TextAlign.left,
              style: GoogleFonts.inter(
                fontSize: 54,
                fontWeight: FontWeight.w900,
                height: 1.2,
                color: const Color.fromRGBO(72, 76, 224, 1),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Track and manage optical prescriptions effortlessly. Save checkup details, lens preferences, and revisit schedules—all in one place!',
              textAlign: TextAlign.left,
              style: GoogleFonts.heebo(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RECENT PRESCRIPTION',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecentPrescriptionScreen(provider.prescriptions)),
                    );
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(72, 76, 224, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                  child: ListView.builder(
                itemCount: provider.prescriptions.length,
                itemBuilder: (context, index) => ListTile(
                  key: ValueKey(provider.prescriptions[index].id),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(provider.prescriptions[index].patientName!),
                        Text(provider.prescriptions[index].lensType!.name),
                        Text(provider.prescriptions[index].date!)
                      ]),
                ),
              )
                  // Text('No recent views yet'),
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          width: 90,
          height: 90,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/form');
            },
            backgroundColor: Colors.black,
            shape: const CircleBorder(), // Keep it circular
            elevation: 6,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40, // Make icon a bit larger too
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class RecentPrescriptionScreen extends StatelessWidget {
  const RecentPrescriptionScreen(this.prescriptions, {super.key});

  final List<Prescription> prescriptions;

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = const Text(
      'List of recent prescriptions will be shown here.',
      style: TextStyle(fontSize: 16),
    );

    if (prescriptions.isNotEmpty) {
      bodyContent = ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(prescriptions[index].patientName!),
            Text(prescriptions[index].lensType!.name),
            Text(prescriptions[index].date!)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Prescriptions'),
      ),
      body: Center(
        child: bodyContent,
      ),
    );
  }
}
