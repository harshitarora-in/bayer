import 'package:bayer/api/weather_api_service.dart';
import 'package:bayer/contants.dart';
import 'package:bayer/getlocation.dart';
import 'package:bayer/pages/news_page.dart';
import 'package:bayer/pages/scan.dart';
import 'package:bayer/pages/shop_websiew.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? temperature;
  dynamic _weatherResponse;
  String sTemperature = '';
  GetLocation getLocation = GetLocation();
  double? longitude = 23;
  double? latitude = 77;
  List<String> _taskList = List<String>.empty(growable: true);

  void updateUi() {
    setState(() {
      temperature = _weatherResponse['main']['temp'];
      sTemperature = temperature!.toStringAsFixed(1);
    });
  }

  void asyncCall() async {
    await getLocation.getCurrentLocation();
    longitude = getLocation.longitude;
    latitude = getLocation.latitude;
    WeatherApiServices weatherApiCall = WeatherApiServices(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=c7af5988ba36e2d1e499452d312368e2&units=metric");
    _weatherResponse = await weatherApiCall.fetchWeatherData();
    updateUi();
  }

  @override
  void initState() {
    asyncCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(150, 50),
                topRight: Radius.elliptical(150, 50)),
            child: Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    kDarkBlue,
                    kBlue,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 130.0, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Daily Tasks",
                            style: GoogleFonts.inter(
                                color: kWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        GestureDetector(
                          child: Text("+ Add Tasks",
                              style: GoogleFonts.inter(
                                  color: kWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          onTap: () {
                            showTextfieldPopup(context);
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Seeding is done on 28-11-2021",
                                style: GoogleFonts.inter(
                                    color: kWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            Text("Do give water to the crop",
                                style: GoogleFonts.inter(
                                    color: kWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            Text("Shop all the required products from bayer",
                                style: GoogleFonts.inter(
                                    color: kWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            Text("Watch resources for knowledge",
                                style: GoogleFonts.inter(
                                    color: kWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
          Widget1(
            weather: sTemperature.toString(),
          ),
        ],
      ),
    );
  }

  showTextfieldPopup(BuildContext context) {
    Alert(
        context: context,
        //title: "Add new task",
        content: Column(
          children: [
            TextField(
              cursorColor: kDarkBlue,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkBlue, width: 2.0)),
                  labelStyle: const TextStyle(color: Colors.black),
                  labelText: "Add task",
                  hintText: "New task",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: kDarkBlue,
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}

class Widget1 extends StatelessWidget {
  const Widget1({Key? key, required this.weather}) : super(key: key);
  final String? weather;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 160,
                  width: 160,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/images/01d.png',
                      height: 140,
                      width: 140,
                    ),
                  ),
                ),
                Text(
                    weather.toString().isNotEmpty
                        ? weather.toString() + '°'
                        : '',
                    style: GoogleFonts.inter(
                        color: kWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Shop()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: kWhite,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(60))),
                    width: 160,
                    height: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Image.asset(
                    'assets/images/shoponline.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  top: 130,
                  child: Text('Shop',
                      style: GoogleFonts.inter(
                          color: kDarkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(60))),
                  width: 160,
                  height: 160,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Image.asset(
                      'assets/images/label.png',
                      height: 85,
                      width: 85,
                    ),
                  ),
                ),
                Positioned(
                  top: 115,
                  child: Text('QR Code',
                      style: GoogleFonts.inter(
                          color: kDarkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(60))),
                  width: 160,
                  height: 160,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Image.asset(
                      'assets/images/resources.png',
                      height: 90,
                      width: 90,
                    ),
                  ),
                ),
                Positioned(
                  top: 115,
                  child: Text('Updates',
                      style: GoogleFonts.inter(
                          color: kDarkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
