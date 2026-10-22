import 'package:paylatter/models/payment_method_model.dart';
import 'package:paylatter/models/transaction_type_model.dart';

class TransactionModel {
  final int? id;
  final int? amount;
  final DateTime? createdAt;
  final TransactionTypeModel? transactionType;
  final PaymentMethodModel? paymentMethod;

  TransactionModel({
    this.id,
    this.amount,
    this.createdAt,
    this.transactionType,
    this.paymentMethod,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        amount: json['amount'],
        createdAt: DateTime.tryParse(json['created_at']),
        transactionType: json['transaction_type'] == null
            ? null
            : TransactionTypeModel.fromJson(
                json['transaction_type'],
              ),
        paymentMethod: json['payment_method'] == null
            ? null
            : PaymentMethodModel.fromJson(
                json['payment_method'],
              ),
      );
}
