import 'package:flutter/material.dart';

const kGreen = Color(0xFF89D329);
const kBlue = Color(0xFF00BCFF);
const kDarkBlue = Color(0xFF10384F);
const kPink = Color(0xFFFF3162);
const kWhite = Color(0xFFFFFFFF);
const kGrey = Color(0xFFF3F4F7);
DateTime _today = DateTime.now();
DateTime _pastMonth = _today.subtract(const Duration(days: 28));
String date = _pastMonth.year.toString() +
    _pastMonth.month.toString() +
    _pastMonth.day.toString();

class Constants {
  static String openWeatherKey = "c7af5988ba36e2d1e499452d312368e2";
  static String openWeatherUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=delhi&appid=";
  //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
  String getNewsLink({required String newsCategory}) {
    String newsUrl =
        "https://newsapi.org/v2/everything?q=$newsCategory&language=en&from=$date&sortBy=publishedAt&apiKey=9b2c27eee5834809b2811edc685746d1";
    return newsUrl;
  }
}
