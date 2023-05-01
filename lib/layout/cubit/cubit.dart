import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/appointment_screen/appointments_screen.dart';
import 'package:login_register_methods/module/categories_screen/categories_screen.dart';
import 'package:login_register_methods/module/home_screen/home_screen.dart';
import 'package:login_register_methods/module/suppliers_screen/suppliers_screen.dart';

import '../../model/user_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/local/cache_helper.dart';

class LayoutCubit extends Cubit<LayoutStates>{

  LayoutCubit() : super(LayoutInitState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  //  Cubit for BottomNavBar
  int currentIndex = 0;
  void changeBottomNav(int index){
    currentIndex = index;
    emit(ChatChangeBottomNavState());
  }

  List<Widget> screens = [
    const  HomeScreen(),
     CategoriesScreen(),
     SuppliersScreen(),
     AppointmentsScreen(),
  ];
  //////////////////////////////////

  ///SingOut
  void singOut() {
    CacheHelper.removeData(key: 'uid').then((value) {
      emit(SignOutSuccessState());
    });
  }

  ///Get User Data from Firebase FireStore
  UserModel? originalUser;
  void getUserData(){
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uid).get().then((value) {
      originalUser = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    });
  }

}