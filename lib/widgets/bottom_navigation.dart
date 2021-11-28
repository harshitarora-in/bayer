import 'package:bayer/contants.dart';
import 'package:bayer/pages/news_page.dart';
import 'package:bayer/pages/scan.dart';
import 'package:bayer/pages/calculate_page.dart';
import 'package:bayer/pages/homepage.dart';
import 'package:bayer/pages/weather_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  List pages = [
    const HomePage(),
    const WeatherPage(),
    const Scan(),
    const NewsPage(),
    const NotificationPage(),
  ];
  List<String> titleText = ['Bayer', 'Weather', 'Scan QR', 'News', 'Calculate'];
  int temp = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kDarkBlue,
          title: Text(titleText[temp]),
          automaticallyImplyLeading: false,
        ),
        body: pages[temp],
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            style: TabStyle.fixedCircle,
            height: 65,
            color: Colors.grey,
            activeColor: kWhite,
            curveSize: 110,
            backgroundColor: kDarkBlue,
            items: const [
              TabItem(icon: CupertinoIcons.home, title: 'Home'),
              TabItem(icon: CupertinoIcons.cloud_moon_rain, title: 'Weather'),
              TabItem(icon: CupertinoIcons.qrcode_viewfinder, title: 'Scan'),
              TabItem(icon: CupertinoIcons.news, title: 'News'),
              TabItem(icon: Icons.calculate_outlined, title: 'Calculate'),
            ],
            initialActiveIndex: temp,
            onTap: (index) {
              setState(() {
                temp = index;
              });
            },
            //optional, default as 0
          ),
        ));
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 24;

  @override
  TextStyle textStyle(Color color) {
    return const TextStyle(fontSize: 11, color: Colors.white, height: 1.7);
  }
}
