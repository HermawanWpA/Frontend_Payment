import 'package:paylatter/models/payment_method_model.dart';
import 'package:paylatter/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentMethodService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse('$baseUrl/payment_methods'),
        headers: {
          'Authorization': token,
        },
      );

      // print(res.body);

      if (res.statusCode == 200) {
        List<PaymentMethodModel> paymentMethods = List<PaymentMethodModel>.from(
          jsonDecode(res.body).map(
            (paymentMethod) => PaymentMethodModel.fromJson(paymentMethod),
          ),
        ).toList();

        return paymentMethods;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
}
