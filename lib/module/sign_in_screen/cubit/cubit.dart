import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/local/cache_helper.dart';


class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitialState());

  static SignInCubit get(context) => BlocProvider.of(context);

  IconData passSuffix = TablerIcons.eye_off;
  bool isInvisible = true;
  void changePasswordVisibility() {
    isInvisible = !isInvisible;
    passSuffix = isInvisible ? TablerIcons.eye_off : TablerIcons.eye;

    emit(PasswordVisibilityChangeState());
  }

  void userSignIn({
    required String email,
    required String password
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      uId = value.user!.uid;
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  ////////////////////////////
  /// to dark mode
  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if(fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else{
       isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });
  }
  }






}
