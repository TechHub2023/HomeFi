import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_fi/app/data/models/adafruit_get.dart';
import 'package:http/http.dart' as http;

class TempHumidAPI {
  static String username = 'blairripper';
  static String? aioKey = dotenv.env['API_Key'].toString();
  static String tempFeed = 'temperature';
  static String humidFeed = 'humidity';
  static String led1Feed = 'led-1';
  static String mainURL = 'https://io.adafruit.com/api/v2/';

  static Future<AdafruitGET> getTempData() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$tempFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<AdafruitGET> getHumidData() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$humidFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<AdafruitGET> getLed1Data() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$led1Feed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<AdafruitGET> updateLed1Data(int value) async {
    http.Response response = await http.put(
      Uri.parse(mainURL + '$username/feeds/$led1Feed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
      body: {}
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }
}
