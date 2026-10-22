import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paylatter/services/auth_service.dart';

class WalletService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<void> updatePin(String oldPin, String newPin) async {
    try {
      final String token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse('$baseUrl/wallets'),
        body: {
          'previous_pin': oldPin,
          'new_pin': newPin,
        },
        headers: {
          'Authorization': token,
        },
      );

      // print(res.body);

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
