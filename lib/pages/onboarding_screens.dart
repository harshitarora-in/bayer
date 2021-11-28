import 'package:bayer/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../contants.dart';
import 'homepage.dart';

List<Color> bgColorsList = [
  const Color(0xAAFFAF4E),
  const Color(0xAA1FB090),
  const Color(0xFFFFBE97)
];
List<PageViewModel> introScreenPages() {
  return [
    PageViewModel(
      decoration: PageDecoration(
          titleTextStyle: GoogleFonts.inter(
              color: kWhite, fontSize: 32, fontWeight: FontWeight.w600),
          bodyTextStyle: GoogleFonts.inter(color: kWhite, fontSize: 24),
          imagePadding: const EdgeInsets.only(top: 40),
          imageFlex: 2),
      title: 'LATEST NEWS',
      body: 'Get Notify with Latest News',
      image: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child:
            Image.asset('assets/images/resources.png', height: 300, width: 300),
      ),
    ),
    PageViewModel(
      decoration: PageDecoration(
          titleTextStyle: GoogleFonts.inter(
              color: kWhite, fontSize: 32, fontWeight: FontWeight.w600),
          bodyTextStyle: GoogleFonts.inter(color: kWhite, fontSize: 24),
          imagePadding: const EdgeInsets.only(top: 40),
          imageFlex: 2),

      title: 'PRODUCT DETAILS',
      body: 'Get all products details and resources',
      image: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child:
            Image.asset('assets/images/moreinfo.png', height: 300, width: 300),
      ),
      //footer: const Text('Footer Text')
    ),
    PageViewModel(
      decoration: PageDecoration(
          titleTextStyle: GoogleFonts.inter(
              color: kWhite, fontSize: 32, fontWeight: FontWeight.w600),
          bodyTextStyle: GoogleFonts.inter(color: kWhite, fontSize: 24),
          imagePadding: const EdgeInsets.only(top: 40),
          imageFlex: 2),
      title: 'VERIFY PRODUCT',
      body: 'Verify product by scanning QR code',
      image: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Image.asset('assets/images/secure.png', height: 300, width: 300),
      ),
      //footer: const Text('Footer Text')
    ),
  ];
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Color bgColor = bgColorsList[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      globalBackgroundColor: bgColor,
      onChange: (page) {
        setState(() {
          bgColor = bgColorsList[page];
        });
      },
      pages: introScreenPages(),
      showNextButton: true,
      next: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
          Text(
            'Next',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.arrow_forward_ios,
            size: 12,
          )
        ]),
      ),
      nextColor: kWhite,
      done: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
          Text(
            'Done',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.arrow_forward_ios,
            size: 12,
          )
        ]),
      ),
      doneColor: kWhite,
      onDone: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CustomBottomNavigation()));
        // When done button is press
      },
      dotsFlex: 1,
      controlsPadding: EdgeInsets.zero,
      dotsDecorator: const DotsDecorator(
        color: kWhite,
        activeColor: kWhite,
        size: Size.square(7),
        activeSize: Size(25.0, 7.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    ));
  }
}
