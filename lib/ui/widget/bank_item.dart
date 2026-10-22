import 'package:flutter/material.dart';
import 'package:paylatter/blocs/payment_method/payment_method_bloc.dart';
import 'package:paylatter/models/payment_method_model.dart';
import 'package:paylatter/shared/theme.dart';

class BankItem extends StatelessWidget {
  final PaymentMethodModel paymentMethodModel;
  final bool isSelected;
  const BankItem({
    super.key,
    required this.paymentMethodModel,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: whiteColor,
        border:
            Border.all(width: 2, color: isSelected ? blueColor : whiteColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            paymentMethodModel.thumbnail.toString(),
            width: 96,
          ),
          const SizedBox(
            width: 107,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                paymentMethodModel.name.toString(),
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                '50 Menit',
                style: greyTextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
