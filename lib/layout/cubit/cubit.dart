import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/appointment_screen/appointments_screen.dart';
import 'package:login_register_methods/module/categories_screen/categories_screen.dart';
import 'package:login_register_methods/module/home_screen/home_screen.dart';
import 'package:login_register_methods/module/suppliers_screen/suppliers_screen.dart';

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

}