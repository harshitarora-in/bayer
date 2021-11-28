import 'dart:ui';
import 'package:bayer/api/weather_api_service.dart';
import 'package:bayer/contants.dart';
import 'package:bayer/getlocation.dart';
import 'package:bayer/methods.dart/date_methods.dart';
import 'package:bayer/methods.dart/aqi_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  dynamic aqiResponse;
  dynamic _weatherResponse;
  dynamic forecastResponse;
  GetDates getDates = GetDates();
  GetLocation getLocation = GetLocation();
  AqiMethods aqiMethods = AqiMethods();
  String aqi = 'N/A';
  Color aqiColor = Colors.black;
  double? longitude = 23;
  double? latitude = 77;
  String? city;
  double? temperature;
  num? wind;
  int? humidity;
  String? weather;
  String sTemperature = '0';
  String? imageNumber = '01n';
  List<double> forecastData = List.filled(7, 0);
  List<String> forecastIcon = List.filled(7, '01d');
  List<String> forecastdates = List.filled(7, '29 Dec');
  DateTime today = DateTime.now();

  void updateUi() {
    int aqiLevel = aqiResponse['list'][0]['main']['aqi'];
    setState(() {
      aqi = aqiMethods.getAqiStatus(aqiLevel);
      aqiColor = aqiMethods.getAqiStatusColor(aqiLevel);
      temperature = _weatherResponse['main']['temp'];
      sTemperature = temperature!.toStringAsFixed(1);
      humidity = _weatherResponse['main']['humidity'];
      wind = _weatherResponse['wind']['speed'];
      city = _weatherResponse['name'];
      weather = _weatherResponse['weather'][0]['main'];
      imageNumber = _weatherResponse['weather'][0]['icon'];
      for (int i = 0; i < 7; i++) {
        forecastData[i] = forecastResponse['daily'][i]['temp']['day'];
        forecastIcon[i] = forecastResponse['daily'][i]['weather'][0]['icon'];
        DateTime futureDateData = today.add(Duration(days: i));
        String futureDate = futureDateData.day.toString();
        String futureMonth = getDates.getMonth(futureDateData.month);
        forecastdates[i] = futureDate + ' ' + futureMonth;
      }
    });
    print(aqiLevel);
    print(latitude);
    print(longitude);
  }

  void asyncCall() async {
    await getLocation.getCurrentLocation();
    longitude = getLocation.longitude;
    latitude = getLocation.latitude;
    WeatherApiServices aqiApiCall = WeatherApiServices(
        url:
            "http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$latitude&lon=$longitude&appid=" +
                Constants.openWeatherKey);
    WeatherApiServices weatherApiCall = WeatherApiServices(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=c7af5988ba36e2d1e499452d312368e2&units=metric");
    WeatherApiServices forecastApiCall = WeatherApiServices(
        url:
            "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=current,hourly,minutely,alerts&appid=c7af5988ba36e2d1e499452d312368e2&units=metric");
    _weatherResponse = await weatherApiCall.fetchWeatherData();
    aqiResponse = await aqiApiCall.fetchWeatherData();
    forecastResponse = await forecastApiCall.fetchWeatherData();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //const SearchBar(),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: MediaQuery.of(context).size.height / 3.7,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black38,
                                BlendMode.overlay,
                              ),
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 65.0, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    city.toString(),
                                    style: const TextStyle(
                                        color: kWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.5),
                                  ),
                                  Text(weather.toString(),
                                      style: GoogleFonts.inter(
                                        color: kWhite,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sTemperature + '°',
                                    style: const TextStyle(
                                        fontSize: 56,
                                        fontWeight: FontWeight.bold,
                                        color: kWhite),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5),
                                    child: Text(
                                        today.day.toString() +
                                            ' ' +
                                            getDates.getMonth(today.month) +
                                            ' ' +
                                            today.year.toString(),
                                        style: GoogleFonts.inter(
                                            color: kWhite,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Positioned(
                    top: -20,
                    left: 10,
                    child: Image.asset(
                      'assets/images/$imageNumber.png',
                      height: 130,
                      width: 130,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 15),
              height: 70,
              decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Wind',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        wind.toString() + ' km/hr',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 2,
                      width: 1,
                      indent: 5,
                      endIndent: 0,
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'AQI',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        aqi,
                        style: TextStyle(
                            color: aqiColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 2,
                      width: 1,
                      indent: 5,
                      endIndent: 0,
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Humidity',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        humidity.toString() + ' %',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 400,
              padding: EdgeInsets.only(bottom: 40),
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
//TODO: add graph here
              decoration: const BoxDecoration(
                  color: kDarkBlue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 15, left: 20),
                    child: Text('FORECAST',
                        style: GoogleFonts.inter(
                            color: kWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 125,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: forecastData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 105,
                          child: Card(
                              color: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              margin: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(forecastdates[index],
                                      style: GoogleFonts.inter(
                                          color: kWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Image.asset(
                                    'assets/images/${forecastIcon[index]}.png',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(forecastData[index].toString() + '°',
                                      style: GoogleFonts.inter(
                                          color: kWhite,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500))
                                ],
                              )),
                        );
                      },
                    ),
                  )
                  //TODO: add graph and 7 day forecast https://api.openweathermap.org/data/2.5/onecall?lat=27&lon=77&exclude=current,hourly,minutely,alerts&appid=c7af5988ba36e2d1e499452d312368e2&units=metric
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
        cursorColor: kDarkBlue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          filled: true,
          fillColor: Colors.white70,
          hintText: 'Search city',
          hintStyle: TextStyle(color: kDarkBlue),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: kDarkBlue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: kDarkBlue),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: kDarkBlue, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ));
  }
}
