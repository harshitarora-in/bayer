import 'dart:convert';
import 'package:http/http.dart';

class WeatherApiServices {
  final String url;
  WeatherApiServices({required this.url});
  Future fetchWeatherData() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      String apiData = response.body;
      return jsonDecode(apiData);
    } else {
      print(response.statusCode);
    }
  }
}
