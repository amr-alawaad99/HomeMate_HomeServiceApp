
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_register_methods/model/user_model.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:login_register_methods/shared/components/constants.dart';

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
    required String name,
    required String userName,
    required String phoneNumber,
    required String email,
    required String uid,
    required bool isUser,
    bool isVerified = false,
  }) {
    UserModel userModel = UserModel(
      uid: uid,
      profileName: name,
      username: userName,
      address: "Not defined",
      gpsLocation: '',
      email: email,
      phoneNumber: phoneNumber,
      isVerified: isVerified,
      profilePic:
          "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1683814060~exp=1683814660~hmac=4705fb79b3a531709bff00d930256c2bc9d17c0767e36d812dc2fefd9fc875ef",
      isUser: isUser,
    );

    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .set(userModel.toMap())
        .then((value) {
      uId = uid;
      emit(CreateUserSuccessState(uid));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  ///Register user using Firebase Auth
  registerUserAccount({
    required String email,
    required String password,
    required String name,
    required String userName,
    required String phoneNumber,
    required bool isUser,
  }) {
    emit(CreateUserLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _createUserAccount(
          name: name,
          userName: userName,
          phoneNumber: phoneNumber,
          email: email,
          uid: value.user!.uid,
          isUser: isUser,
      );
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  ///Check username
  bool? usernameExists;
  Future<void> checkUsername(String username) async {
    await FirebaseFirestore.instance.collection("Users").get().then((value) {
      if (value.size == 0) {
        usernameExists = false;
      } else {
        for (var element in value.docs) {
          if (element.data()['username'].toString() == username) {
            usernameExists = true;
            break;
          } else if (element.data()['username'].toString() != username) {
            usernameExists = false;
          }
        }
      }
      print(usernameExists);
      emit(UsernameCheckingSuccessState());
    }).catchError((error) {
      emit(UsernameCheckingErrorState(error.toString()));
    });
  }

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

  /// Sign Up with Google
  googleSignUp({
    required String userName,
    required String phoneNumber,
}) async {
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

    // sign in
    await auth.signInWithCredential(credential!).then((value) {
      _createUserAccount(name: googleUser!.displayName!, userName: userName,
         isUser: true, phoneNumber: phoneNumber, email: googleUser!.email, uid: value.user!.uid, isVerified: true);
    });
  }









}
