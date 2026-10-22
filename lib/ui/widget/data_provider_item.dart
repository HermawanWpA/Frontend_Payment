import 'package:flutter/material.dart';
import 'package:paylatter/models/operator_card_model.dart';
import 'package:paylatter/shared/theme.dart';

class DataProviderItem extends StatelessWidget {
  final OperatorCardModel operatorCardModel;
  final bool isSelected;

  const DataProviderItem({
    super.key,
    required this.operatorCardModel,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
          border: isSelected ? Border.all(width: 2, color: blueColor) : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            operatorCardModel.thumbnail.toString(),
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                operatorCardModel.name.toString(),
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                operatorCardModel.status.toString(),
                style: greyTextStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
