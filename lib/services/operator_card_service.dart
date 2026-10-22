import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paylatter/models/operator_card_model.dart';
import 'package:paylatter/services/auth_service.dart';

class OperatorCardService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<OperatorCardModel>> getOperatorCards() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
          Uri.parse(
            '$baseUrl/operator_cards',
          ),
          headers: {
            'Authorization': token,
          });

      if (res.statusCode == 200) {
        return List<OperatorCardModel>.from(
          jsonDecode(res.body)['data'].map(
            (operatorCard) => OperatorCardModel.fromJson(
              operatorCard,
            ),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
