import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromARGB(255, 242, 242, 253);
    
    return Scaffold(
      backgroundColor: myColor,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(72, 76, 224, 1)
              ),
              
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
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
            Icon(Icons.abc_outlined),
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
            SizedBox(height: 20),
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
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
                          builder: (context) => RecentPrescriptionScreen()),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(72, 76, 224, 1),

                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white ,
              ),
              child: Center(
                child: Text('No recent views yet'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Prescriptions'),
      ),
      body: Center(
        child: Text(
          'List of recent prescriptions will be shown here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
