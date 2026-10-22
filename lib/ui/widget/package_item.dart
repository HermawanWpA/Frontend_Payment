import 'package:flutter/material.dart';
import 'package:paylatter/models/data_plan_model.dart';
import 'package:paylatter/shared/shared_methods.dart';
import 'package:paylatter/shared/theme.dart';

class PackageItem extends StatelessWidget {
  final bool isSelected;
  final DataPlanModel dataPlanModel;
  const PackageItem({
    super.key,
    required this.dataPlanModel,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 176,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 22,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? blueColor : whiteColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 13,
          ),
          Text(
            dataPlanModel.name.toString(),
            style: blackTextStyle.copyWith(fontSize: 32, fontWeight: medium),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            formatCurrency(dataPlanModel.price ?? 0),
            style: greyTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
