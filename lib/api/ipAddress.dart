import 'package:http/http.dart' as https;
class Ipaddress{

  static Future<String?> getIP()async {
    try {
      final url = Uri.parse('https://api.ipify.org');
      final resp = await https.get(url);
      return resp.statusCode == 200 ? resp.body : resp.statusCode.toString();
    }
    catch(ex){
      return ex.toString();
    }
  }


}