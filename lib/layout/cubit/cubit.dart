import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/appointment_screen/appointments_screen.dart';
import 'package:login_register_methods/module/categories_screen/categories_screen.dart';
import 'package:login_register_methods/module/home_screen/home_screen.dart';
import 'package:login_register_methods/module/suppliers_screen/suppliers_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../model/user_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/local/cache_helper.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  //  Cubit for BottomNavBar
  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChatChangeBottomNavState());
  }

  List<Widget> screens = [
    const HomeScreen(),
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

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      originalUser = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    });
  }

  /// Choose Pic from device using ImagePicker
  File? profilePic;
  ImagePicker picker = ImagePicker();

  Future<void> getProfilePic() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profilePic = File(image.path);
      emit(GetProfileImageSuccessState());
    } else {
      print('get profile image ERROR!');
      emit(GetProfileImageErrorState());
    }
  }

  /// Upload picked picture to Firebase storage
  void uploadProfilePic({
    String? profileName,
    String? address,
    String? gpsLocation,
  }) {
    emit(UploadProfilePicLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'Users/profile_pictures/$uId/${Uri.file(profilePic!.path).pathSegments.last}')
        .putFile(profilePic!)
        .then((value) {
      value.ref.getDownloadURL().then((value2) {
        updateUserProfile(
          profilePic: value2,
          profileName: profileName,
          address: address,
          gpsLocation: gpsLocation,
        );
      }).catchError((error) {
        print('1:');
        emit(UploadProfilePicErrorState(error.toString()));
      });
    }).catchError((error) {
      print("2:");
      emit(UploadProfilePicErrorState(error.toString()));
    });
  }

  /// updating user data in FireStore then in the UserModel
  void updateUserProfile({
    String? profileName,
    String? profilePic,
    String? address,
    String? gpsLocation,
  }) {
    UserModel updatedModel = UserModel(
      profileName: profileName ?? originalUser!.profileName,
      address: address ?? originalUser!.address,
      gpsLocation: gpsLocation ?? originalUser!.gpsLocation,
      profilePic: profilePic ?? originalUser!.profilePic,
      phoneNumber: originalUser!.phoneNumber,
      email: originalUser!.email,
      isUser: originalUser!.isUser,
      isVerified: originalUser!.isVerified,
      username: originalUser!.username,
      uid: originalUser!.uid,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(originalUser!.uid)
        .update(updatedModel.toMap())
        .then((value) {
      getUserData();
      this.profilePic = null;
    }).catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }


  String? currentPosition;
  void updateCurrentPositionOnGPS(String lastPosition){
    currentPosition = lastPosition;
    emit(ChangeCurrentPositionSuccessState());
  }
}
