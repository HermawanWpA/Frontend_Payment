import 'dart:convert';

import 'package:paylatter/models/tips_model.dart';
import 'package:paylatter/services/auth_service.dart';
import 'package:http/http.dart' as http;

class TipsService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<TipsModel>> getTips() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse('$baseUrl/tips'),
        headers: {
          'Authorization': token,
        },
      );

      // print(res.body);

      if (res.statusCode == 200) {
        List<TipsModel> tips = List<TipsModel>.from(
          jsonDecode(res.body)['data'].map(
            (tip) => TipsModel.fromJson(tip),
          ),
        ).toList();

        return tips;
      }

      return throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
