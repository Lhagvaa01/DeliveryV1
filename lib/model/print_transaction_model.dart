import 'package:deliery_app/model/personal_information_model.dart';
import 'package:deliery_app/model/transition_model.dart';

class PrintTransactionModel {
  PrintTransactionModel(
      {required this.transitionModel, required this.personalInformationModel});

  PersonalInformationModel personalInformationModel;
  TransitionModel? transitionModel;
}
