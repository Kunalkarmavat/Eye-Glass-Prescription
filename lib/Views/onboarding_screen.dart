import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';

class Onboarding extends StatefulWidget {
  // const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentIndex = 0; // To track the current page index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Update the current index on page change
          });
        },
        children: [
          buildPage('assets/images/woman.png', 'SMART \nPRESCRIPTION \nSIMPLIFIED'),
          buildPage('assets/images/man.png', 'ACCURATE \nVISION TESTING \nANYTIME'),
          buildPage('assets/images/woman2.png', 'EASY \nOPTICAL \nDIAGNOSTICS'),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),

        height: 160,
        color: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? const Color.fromRGBO(72, 76, 224, 1)
                            : Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 34),
            Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white, // Set background color to white
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 12),
          side: BorderSide(color: Color.fromARGB(164, 0, 0, 0), width: 2), // Border color and width
        ),
        onPressed: () {
          _pageController.jumpToPage(2); // Skip to last page
        },
        child: const Text(
          'Skip',
          style: TextStyle(color: Colors.black), // Text color black
        ),
      ),
      
          ElevatedButton(
            style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Button background color
      padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 12),
            ),
            onPressed: () {
      if (_currentIndex < 2) {
        print(_currentIndex);
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
       
      } else {
         Navigator.pushNamed(context, '/home');
      }
            },
            child: Text(
      _currentIndex == 2 ? 'Get Started' : 'Next',
      style: const TextStyle(color: Colors.white), // Button text color
      
            ),
          ),
        ],
      ),
      
          ],
        ),
      ),
    );
  }

  Widget buildPage(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 122),
          Center(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 300,
              width: 300,
              child: Image.asset(imagePath),
            ),
          ),
          const Divider(thickness: 2, color: Colors.black),
          const SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Get precise optical prescriptions with just a few taps—effortless and accurate',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
