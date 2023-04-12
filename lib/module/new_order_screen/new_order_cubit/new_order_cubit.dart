import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_cubit/new_order_states.dart';

import '../../../models/category_model.dart';
import 'package:flutter/material.dart';

class NewOrderCubit extends Cubit<NewOrderStates>

{
  NewOrderCubit():super(NewOrderInitialState());
  static NewOrderCubit get(context)=> BlocProvider.of(context);

  List<Categories> categories = [
    Categories(
      title: 'Cleaning',
      img: AssetImage('assets/images/cleaning.png'),
    ),
    Categories(
      title: 'Kitchen',
      img: AssetImage('assets/images/kitchen.png'),
    ),
    Categories(
      title: 'Plumbing',
      img: AssetImage('assets/images/plumbing.png'),
    ),
    Categories(
      title: 'Paint',
      img: AssetImage('assets/images/paint.png'),
    ),
    Categories(
      title: 'Carpentry',
      img: AssetImage('assets/images/carpentry.png'),
    ),
    Categories(
      title: 'Electricity',
      img: AssetImage('assets/images/electrician.png'),
    )
  ];

  int selectedIndex = -1;


  void changeIndex(int index){
    selectedIndex=index;
    emit(NewOrderSelectServiceState());

  }

}