import 'package:http/http.dart' as http;
import 'dart:convert';

class CyberTipService {
  Future<String> fetchCyberTip() async {
    final url = Uri.parse('https://api.adviceslip.com/advice');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['slip']['advice'];
    } else {
      return 'Stay safe online and think before you click.';
    }
  }
}
