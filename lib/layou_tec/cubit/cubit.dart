import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layou_tec/cubit/states.dart';
import 'package:login_register_methods/layou_tec/modules/appointment_technical_screen/appointment_screen.dart';
import 'package:login_register_methods/layou_tec/modules/home_technical_screen/home_technical_screen.dart';

import '../../model/user_model.dart';
import '../../module/appointment_screen/appointments_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/local/cache_helper.dart';
import '../modules/history_screen/history_screen.dart';

class LayoutTecCubit extends Cubit<LayoutTecStates> {
  LayoutTecCubit() : super(LayoutTecInitState());

  static LayoutTecCubit get(context) => BlocProvider.of(context);

  //  Cubit for BottomNavBar
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeTechnicalScreen(),
    HistoryScreen(),
    AppointmentTechnicalScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChatChangeBottomNavState());
  }

  UserModel? originalUser;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      originalUser = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    });
  }


  ///SingOut
  void singOut() {
    CacheHelper.removeData(key: 'uid').then((value) {
      emit(SignOutSuccessState());
    });
  }


}