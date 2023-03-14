import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';

class SignupCubit extends Cubit<SignupStates>{
  SignupCubit() : super(SignupInitState());

  static SignupCubit get(context) => BlocProvider.of(context);

  ///
  IconData passSuffix = TablerIcons.eye_off;
  bool isInvisible = true;
  void changePasswordVisibility() {
    isInvisible = !isInvisible;
    passSuffix = isInvisible ? TablerIcons.eye_off : TablerIcons.eye;

    emit(PasswordVisibilityChangeState());
  }


  List<bool> isSelected = List.generate(2, (index) => false);
  void changeSelected(index){
    isSelected.replaceRange(0, isSelected.length, isSelected.map((e) => false));
    isSelected[index] = true;
    emit(IsSelectedChangeState());
  }

  void selectedService(List list, int index){
    for(int i = 0; i < list.length; i++){
      list[i].selected = false;
    }
    list[index].selected = true;
    emit(SelectedServiceChangeState());
  }



}