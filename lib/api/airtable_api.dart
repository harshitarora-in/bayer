import 'dart:convert';
import 'package:http/http.dart';

class AirtableApiServices {
  final String getDataUrl =
      "https://api.airtable.com/v0/appVHPktlT22lWSHY/Table%201?api_key=keyOqo6abUtCx4Dn9";
  AirtableApiServices();
  Future fetchAirtableData() async {
    Response response = await get(Uri.parse(getDataUrl));
    if (response.statusCode == 200) {
      String apiData = response.body;
      return jsonDecode(apiData);
    } else {
      print(response.statusCode);
    }
  }

  Future deleteAirtableRecord({required String record}) async {
    String deleteUrl =
        "https://api.airtable.com/v0/appVHPktlT22lWSHY/Table%201/$record?api_key=keyOqo6abUtCx4Dn9";
    Response response = await delete(Uri.parse(deleteUrl));
    if (response.statusCode == 200) {
      print("deleted successfully");
    } else {
      print("error while deleting");
    }
  }
}
