import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylatter/blocs/auth/auth_bloc.dart';
import 'package:paylatter/blocs/data_plan/data_plan_bloc.dart';
import 'package:paylatter/models/data_plan_form_model.dart';
import 'package:paylatter/models/data_plan_model.dart';
import 'package:paylatter/models/operator_card_model.dart';
import 'package:paylatter/shared/theme.dart';
import 'package:paylatter/ui/widget/buttons.dart';
import 'package:paylatter/ui/widget/forms.dart';
import 'package:paylatter/ui/widget/package_item.dart';
import 'package:quickalert/quickalert.dart';

class DataPackagePage extends StatefulWidget {
  final OperatorCardModel operatorCard;

  const DataPackagePage({super.key, required this.operatorCard});

  @override
  State<DataPackagePage> createState() => _DataPackagePageState();
}

class _DataPackagePageState extends State<DataPackagePage> {
  final phoneController = TextEditingController(text: '');

  DataPlanModel? selectedDataPlan;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPlanBloc(),
      child: BlocConsumer<DataPlanBloc, DataPlanState>(
        listener: (context, state) {
          if (state is DataPlanFailed) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: '',
              text: state.e,
            );
          }
          if (state is DataPlanSuccess) {
            context.read<AuthBloc>().add(
                  AuthUpdateBalance(
                    selectedDataPlan!.price! * -1,
                  ),
                );
            Navigator.pushNamedAndRemoveUntil(
                context, '/data-success', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is DataPlanLoading) {
            const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Paket Data'),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Phone Number',
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomFormField(
                  title: '+62',
                  isShowTitle: false,
                  controller: phoneController,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Select Package',
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                const SizedBox(
                  height: 14,
                ),
                Wrap(
                    spacing: 50,
                    runSpacing: 17,
                    children: widget.operatorCard.dataPlans!.map((dataPlan) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDataPlan = dataPlan;
                          });
                        },
                        child: PackageItem(
                          dataPlanModel: dataPlan,
                          isSelected: dataPlan.id == selectedDataPlan?.id,
                        ),
                      );
                    }).toList()),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            floatingActionButton:
                (selectedDataPlan != null && phoneController.text.isNotEmpty)
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: CustomFilledButton(
                          title: 'Continue',
                          onPressed: () async {
                            if (await Navigator.pushNamed(context, '/pin') ==
                                true) {
                              final authState = context.read<AuthBloc>().state;
                              String pin = '';
                              if (authState is AuthSuccess) {
                                pin = authState.data.pin!;
                              }
                              context.read<DataPlanBloc>().add(
                                    DataPlantPost(
                                      DataPlanFormModel(
                                          dataPlanId: selectedDataPlan!.id,
                                          phoneNumber: phoneController.text,
                                          pin: pin),
                                    ),
                                  );
                            }
                          },
                        ),
                      )
                    : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
