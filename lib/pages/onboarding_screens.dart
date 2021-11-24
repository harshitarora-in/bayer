import 'package:flutter/material.dart';
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
      decoration: const PageDecoration(
          titleTextStyle:
              TextStyle(fontFamily: 'poppins', color: kWhite, fontSize: 24),
          bodyTextStyle:
              TextStyle(fontFamily: 'poppins', color: kWhite, fontSize: 18),
          imagePadding: EdgeInsets.only(top: 40),
          imageFlex: 2),
      title: 'Hey this is first title',
      body: 'This isbody text',
      image: Image.asset('assets/images/1.png'),
      //footer: const Text('Footer Text')
    ),
    PageViewModel(
      decoration: const PageDecoration(
          titleTextStyle:
              TextStyle(fontFamily: 'poppins', color: kWhite, fontSize: 24),
          bodyTextStyle:
              TextStyle(fontFamily: 'poppins', color: kWhite, fontSize: 18),
          imagePadding: EdgeInsets.only(top: 40),
          imageFlex: 2),

      title: 'Hey this is first title',
      body: 'This isbody text',
      image: Image.asset('assets/images/2.png'),
      //footer: const Text('Footer Text')
    ),
    PageViewModel(
      decoration: const PageDecoration(
          titleTextStyle:
              TextStyle(fontFamily: 'poppins', color: kWhite, fontSize: 24),
          bodyTextStyle:
              TextStyle(fontFamily: 'poppins', color: kWhite, fontSize: 18),
          imagePadding: EdgeInsets.only(top: 40),
          imageFlex: 2),
      title: 'Hey this is first title',
      body: 'This isbody text',
      image: Image.asset('assets/images/3.png'),
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
            context, MaterialPageRoute(builder: (context) => const HomePage()));
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
