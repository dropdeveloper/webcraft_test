import 'package:http/http.dart' as http;

class InternetHelper {
  static String url = "http://www.mocky.io/v2/5d565297300000680030a986";

  Future<String> get(String url) async {
    print("Url GET : $url");
    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Error : " +
            response.statusCode.toString() +
            " : " +
            response.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
