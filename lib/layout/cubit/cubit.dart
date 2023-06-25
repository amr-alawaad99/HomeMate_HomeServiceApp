import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/appointment_screen/appointments_screen.dart';
import 'package:login_register_methods/module/categories_screen/categories_screen.dart';
import 'package:login_register_methods/module/home_screen/home_screen.dart';
import 'package:login_register_methods/module/suppliers_screen/suppliers_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ntp/ntp.dart';
import '../../model/category_model.dart';
import '../../model/orderModel.dart';
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
  int appointmentSelectedIndex = 0;
  int suppliersSelectedIndex = 0;

  void changeAppointmentIndex(int index) {
    appointmentSelectedIndex = index;
    emit(AppointmentChangeSelectedState());
  }

  void changeSuppliersIndex(int index) {
    suppliersSelectedIndex = index;
    emit(SuppliersChangeSelectedState());
  }

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
    if (CacheHelper.getData(key: 'uid') == null) {
      originalUser = UserModel();
      return;
    }
    print('hello world');
    uId = CacheHelper.getData(key: 'uid');
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      originalUser = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState(originalUser!.isUser!));
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

  void updateCurrentPositionOnGPS(String lastPosition) {
    currentPosition = lastPosition;
    emit(ChangeCurrentPositionSuccessState());
  }

  ////////////////////////////

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

  void changeIndex(int index) {
    selectedIndex = index;
    emit(NewOrderSelectServiceState());
  }

  List<String> listOfUrls = [];
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  int uploadItem = 0; // List of selected image
  bool uploading = false;
  final firebaseStorage = FirebaseStorage.instance;

  // Instance of Image picker

  //Select Image

  Future<void> selectImages() async {
    if (imageFileList != null) {
      imageFileList!.clear();
    }
    try {
      final List<XFile> selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        imageFileList!.addAll(selectedImages);
      } else {
        print('No image selected');
      }

      emit(
        NewOrderPickImageState(),
      );
    } catch (e) {
      emit(NewOrderPickErrorImageState());
      print('something wrong ' + e.toString());
    }
  }

  clearImage(int index) {
    imageFileList!.removeAt(index);
    emit(
      NewOrderClearPickedImageState(),
    );
  }

  Future<String> uploadFile(
    XFile image,
  ) async {
    Reference reference = firebaseStorage
        .ref()
        .child("Users/orders_pics/${Uri.file(image.path).pathSegments.last}");
    emit(NewOrderUploadImageToFirebaseLoadingState());
    UploadTask uploadTask = reference.putFile(File(image.path));
    await uploadTask.whenComplete(() {
      emit(NewOrderUploadImageToFirebaseSuccessState());
    });
    return await reference.getDownloadURL();
  }

  uploadImage(
    List<XFile> images,
  ) async {
    print(images.length);
    for (int i = 0; i < images.length; i++) {
      var imageUrl = await uploadFile(
        images[i],
      );
      listOfUrls.add(imageUrl.toString());
    }
    emit(NewOrderUploadAllImageToFirebaseSuccessState());
  }

  void orderCreate({
    String? serviceName,
    String? date,
    String? time,
    String? notes,
    String? location,
    String? gpsLocation,
    String? image,
    String? status,
    String? cost,
  }) {
    OrderModel model = OrderModel(
      serviceName: serviceName,
      date: date,
      time: time,
      notes: notes,
      location: location,
      image: image,
      uId: uId,
      dateTimeForOrder: ntpTime.toString(),
      status: status,
      cost: cost,
      gpsLocation: gpsLocation,
      orderUid: "",
    );
    emit(UploadOrderLoadingState());
    FirebaseFirestore.instance
        .collection('orders')
        .doc(uId)
        .collection('user Orders')
        .add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('orders')
          .doc(uId)
          .collection('user Orders')
          .doc(value.id)
          .update({"orderUid": value.id});
      emit(UploadOrderSuccessState());
    }).catchError((error) {
      emit(UploadOrderErrorState());
    });
  }

  List<OrderModel> myOrders = [];

  void getOrders() {
    if (CacheHelper.getData(key: 'uid') == null) {
      myOrders = [];
      return;
    }
    uId = CacheHelper.getData(key: 'uid');
    FirebaseFirestore.instance
        .collection("orders")
        .doc(uId)
        .collection("user Orders")
        .get()
        .then((value) {
      print(value.size);
      for (var element in value.docs) {
        print(element.data()["date"]);
        myOrders.add(OrderModel.fromJson(element.data()));
      }
    }).catchError((error) {
      print("FFFFFFFF $error");
    });
  }

  void removeOrder({required String orderUid}) {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(uId)
        .collection('user Orders')
        .doc(orderUid)
        .delete();
  }

  Stream<List<OrderModel>> orders() {
    return FirebaseFirestore.instance
        .collection("orders")
        .doc(uId)
        .collection("user Orders")
        .orderBy('dateTimeForOrder')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }

  // global date time
  DateTime ntpTime = DateTime.now();

  void loadDateTime() async {
    ntpTime = await NTP.now();
  }

  Stream<List<UserModel>> techs() {
    return FirebaseFirestore.instance
        .collection("Users")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()["isUser"] == false)
          .map((e) => UserModel.fromJson(e.data()))
          .toList();
    });
  }
}
