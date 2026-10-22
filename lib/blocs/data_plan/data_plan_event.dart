part of 'data_plan_bloc.dart';

abstract class DataPlanEvent extends Equatable {
  const DataPlanEvent();

  @override
  List<Object> get props => [];
}

class DataPlantPost extends DataPlanEvent {
  final DataPlanFormModel data;
  const DataPlantPost(this.data);

  @override
  List<Object> get props => [data];
}
