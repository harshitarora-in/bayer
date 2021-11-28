import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  Future fetchNewsModel({required String? url}) async {
    var response = await http.get(Uri.parse(url.toString()));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData;
    } else {
      print('News api response code');
      print(response.statusCode);
    }
  }
}
