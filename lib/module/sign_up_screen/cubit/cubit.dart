import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/model/user_model.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:username_generator/username_generator.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitState());

  static SignupCubit get(context) => BlocProvider.of(context);

  ///Toggle Password Suffix
  IconData passSuffix = TablerIcons.eye_off;
  bool isInvisible = true;

  void changePasswordVisibility() {
    isInvisible = !isInvisible;
    passSuffix = isInvisible ? TablerIcons.eye_off : TablerIcons.eye;

    emit(PasswordVisibilityChangeState());
  }

  ///Toggle checkbox
  bool isChecked = false;

  void toggleCheckbox() {
    isChecked = !isChecked;

    emit(CheckboxToggleChangeState());
  }

  bool isClicked = false;

  void errorCheckBox() {
    isClicked = true;
    emit(CheckboxChangeOnButtonClick());
  }

  ///Toggle between User and Technical
  List<bool> isSelected = List.generate(2, (index) => false);

  void changeSelected(index) {
    isSelected.replaceRange(0, isSelected.length, isSelected.map((e) => false));
    isSelected[index] = true;
    emit(IsSelectedChangeState());
  }

  ///Select service on tech sign up screen
  void selectedService(List list, int index) {
    for (int i = 0; i < list.length; i++) {
      list[i].selected = false;
    }
    list[index].selected = true;
    emit(SelectedServiceChangeState());
  }

  ///Create user in Firebase FireStore
  _createUserAccount({
    required String fName,
    required String lName,
    required String userName,
    required String phoneNumber,
    required String uid,
  }) {
    UserModel userModel = UserModel(
      uid: uid,
      firstName: fName,
      lastName: lName,
      username: userName,
      location: "Not defined",
      phoneNumber: phoneNumber,
      isVerified: false,
      profilePic: "assets/images/default profile pic.jpg",
      isUser: true,
    );

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userName)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uid));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  ///Register user using Firebase Auth
  registerUserAccount({
    required String email,
    required String password,
    required String fName,
    required String lName,
    required String userName,
    required String phoneNumber,
  }) {
    emit(CreateUserLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _createUserAccount(
          fName: fName,
          lName: lName,
          userName: userName,
          phoneNumber: phoneNumber,
          uid: value.user!.uid);
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  ///Check username
  bool? usernameExists;

  Future<bool?> checkUsername(String username) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(username)
        .get()
        .then((value) {
      usernameExists = value.exists;
    }).catchError((error) {
      print(error.toString());
    });
    return usernameExists;
  }
}
