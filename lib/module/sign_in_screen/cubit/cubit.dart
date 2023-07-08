import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';

import '../../../shared/resources/constants_manager.dart';
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

///user signIn
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

  //
  // ///Technical signIn
  // void technicalSignIn({
  //   required String email,
  //   required String password
  // }){
  //   emit(LoginLoadingState());
  //   FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
  //     uId = value.user!.uid;
  //     emit(LoginSuccessState(value.user!.uid));
  //   }).catchError((error){
  //     emit(LoginErrorState(error.toString()));
  //   });
  // }
  // ////////////////////////////



  /// Check if Google account exists or not
  OAuthCredential? credential;
  GoogleSignInAccount? googleUser;
  checkGoogleAccountExistence() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    googleUser = gUser;

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create new credential for user
    credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Check if the user already exists
    final email = gUser.email;
    final signInMethods = await auth.fetchSignInMethodsForEmail(email);
    if (signInMethods.isNotEmpty) {
      // User already exists, handle accordingly
      await auth.signInWithCredential(credential!).then((value) {
        uId = value.user!.uid;
        emit(UserAlreadyExistsState(value.user!.uid));
      });
    } else {
      emit(UserDoesNotExistsState());
    }
  }


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


  ///Toggle between User and Technical
  List<bool> isSelected = List.generate(2, (index) => false);

  void changeSelected(index) {
    isSelected.replaceRange(0, isSelected.length, isSelected.map((e) => false));
    isSelected[index] = true;
    emit(IsSelectedChangeState());
  }





}
