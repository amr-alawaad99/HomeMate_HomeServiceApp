import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import '../../layout_tec/modules/history_screen/history_screen.dart';
import '../../layout_tec/modules/home_technical_screen/home_technical_screen.dart';
import '../../layout_tec/modules/oder_tec_screen/order_tec_screen.dart';
import '../../model/category_model.dart';
import '../../model/cost_model.dart';
import '../../model/orderModel.dart';
import '../../model/user_model.dart';

import '../../shared/components/components.dart';
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

  List<Widget> tecScreens = [
    HomeTechnicalScreen(),
    OrderTechnicalScreen(),
    HistoryScreen(),
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

  getUserData() {
    currentIndex = 0;
    emit(GetUserDataLoadingState());
    if (CacheHelper.getData(key: 'uid') == null) {
      originalUser = UserModel();
      return;
    }
    print('hello world');
    uId = CacheHelper.getData(key: 'uid');
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      originalUser = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: "isUser", value: originalUser!.isUser!);
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
      serviceName: originalUser!.serviceName,
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
    listOfUrls = [];
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
      technicalUId: '',
    );
    emit(UploadOrderLoadingState());
    FirebaseFirestore.instance
        .collection('orders')
        .add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('orders')
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
    FirebaseFirestore.instance.collection("orders").get().then((value) {
      for (var element in value.docs) {
        myOrders.add(OrderModel.fromJson(element.data()));
      }
    }).catchError((error) {});
  }

  void removeOrder({required String orderUid}) {
    FirebaseFirestore.instance.collection('orders').doc(orderUid).delete();
  }

  Stream<List<OrderModel>> allUserOrders(String uId) {
    return FirebaseFirestore.instance
        .collection("orders")
        .orderBy('dateTimeForOrder')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((element) => element.data()["uId"] == uId)
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }
  Stream<List<OrderModel>> orders(String uId,String status) {
    return FirebaseFirestore.instance
        .collection("orders")
        .orderBy('dateTimeForOrder')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((element) => element.data()["uId"] == uId).where((element) => element.data()['status']== status)
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }

  // global date time
  DateTime ntpTime = DateTime.now();

  void loadDateTime() async {
    ntpTime = await NTP.now();
  }

  Stream<List<UserModel>> suppliers(String service) {
    return FirebaseFirestore.instance
        .collection("Users")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()["isUser"] == false).where((element) => element.data()['serviceName']== service)
          .map((e) => UserModel.fromJson(e.data()))
          .toList();
    });
  }
  Stream<List<UserModel>> allSuppliers() {
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

  Stream<List<OrderModel>> allOrders(String serviceName) {
    return FirebaseFirestore.instance
        .collection("orders")
        .orderBy('dateTimeForOrder')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()["serviceName"] == serviceName)
          .where((element) => element.data()["status"] == "waiting")
          .map((e) => OrderModel.fromJson(e.data()))
          .toList();
    });
  }

  Stream<List<OrderModel>> finishedOrders(String serviceName, String uId) {
    return FirebaseFirestore.instance
        .collection("orders")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()["serviceName"] == serviceName)
          .where((element) => element.data()["status"] == "finished")
          .where((element) => element.data()['technicalUId'] == uId)
          .map(
            (e) => OrderModel.fromJson(
              e.data(),
            ),
          )
          .toList();
    });
  }

  sendOTP() async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+20${originalUser!.phoneNumber}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("VERFICATION COMPLETED SUCCESSFULLLLLLLLLLLLLLLYYYYYYYYYYY");
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == "invalid-phone-number") {
            showToast(message: "Invalid phone number", toastColor: errorColor);
          } else {
            showToast(message: e.message.toString(), toastColor: errorColor);
            emit(VerificationCodeSentErrorState(e.toString()));
          }
        },
        codeSent: (verificationId, forceResendingToken) {
          showToast(
              message: "a verification code has been sent to your phone number",
              toastColor: successColor);
          emit(VerificationCodeSentSuccessState(verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 60));
  }

  verifyOTP({
    required String verificationId,
    required String otpCode,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );
    FirebaseAuth.instance.currentUser!
        .linkWithCredential(credential)
        .then((value) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(uId)
          .update({"isVerified": true});
      emit(VerificationSuccessState());
    }).catchError((error) {
      showToast(message: error.toString(), toastColor: errorColor);
    });
  }

  void offerCreate({
    String? cost,
    String? username,
    String? image,
    String? orderUId,
    String? uId,
  }) {
    OfferModel model = OfferModel(
      orderUId: orderUId,
      cost: cost,
      image: image,
      profileName: username,
      uId: uId,
      status: 'waiting',
    );
    emit(UploadOfferLoadingState());
    FirebaseFirestore.instance
        .collection('offers')
        .add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('offers')
          .doc(value.id)
          .update({"offerUId": value.id});
      emit(UploadOfferSuccessState());
    }).catchError((onError) {
      emit(UploadOfferErrorState());
    });
  }

  bool? isOffered;

  checkOffers(String orderUId, String techUId) async {
    emit(CheckOfferLoadingState());
    await FirebaseFirestore.instance.collection('offers').get().then((value) {
      isOffered = value.docs
          .where((element) => element.data()['orderUId'] == orderUId)
          .where((element) => element.data()['uId'] == techUId)
          .isNotEmpty;
    }).then((value) {
      emit(CheckOfferSuccessState());
    }).catchError((error) {
      emit(CheckOfferSuccessState());
    });
  }

// update order in user screen
  void updateUserAppointment({
    String? orderUid,
    String? cost,
    String? profileName,
    String? profilePic,
    String? technicalUId,
  }) {
    FirebaseFirestore.instance.collection('orders').doc(orderUid).update({
      'cost': cost,
      'profileName': profileName,
      'profilePic': profilePic,
      'status': 'underway',
      'technicalUId': technicalUId,
    });
  }

  //update offer for technical

  void updateTechnicalOrder({
    String? offerUid,
  }) {
    FirebaseFirestore.instance
        .collection('offers')
        .doc(offerUid)
        .update({'status': 'accepted'});
  }

  Stream<List<OfferModel>> userOffer(String orderUId, String techUId) {
    return FirebaseFirestore.instance
        .collection("offers")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()['orderUId'] == orderUId)
          .where((element) => element.data()['uId'] == techUId)
          .map((e) => OfferModel.fromJson(e.data()))
          .toList();
    });
  }

////////////////////////////////////////////////
//   appointment offer in user appointment details

  int offerIndex = -1;

  void selectedOffer(List list, int index) {
    if (offerIndex != index) {
      offerIndex = index;
    } else {
      offerIndex = -1;
    }
    emit(IsSelectedState());
  }

  Stream<List<OfferModel>> allOrderOffers(
    String orderUId,
  ) {
    return FirebaseFirestore.instance
        .collection("offers")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()['orderUId'] == orderUId)
          // .where((element) => element.data()['status'] == 'accepted')
          .map((e) => OfferModel.fromJson(e.data()))
          .toList();
    });
  }


  Stream<int> allOrderOffersLength(
      String orderUId,
      ) {
    return FirebaseFirestore.instance
        .collection("offers")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()['orderUId'] == orderUId)
      // .where((element) => element.data()['status'] == 'accepted')
          .map((e) => OfferModel.fromJson(e.data()))
          .toList().length;
    });
  }

  Stream<List<OfferModel>> acceptedOffer(
    String orderUId,
  ) {
    return FirebaseFirestore.instance
        .collection("offers")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()['orderUId'] == orderUId)
          .where((element) => element.data()['status'] == 'accepted')
          .map((e) => OfferModel.fromJson(e.data()))
          .toList();
    });
  }

  // handle tabView

  int currentTabIndex = 0;

  void changeTabView(int index) {
    currentTabIndex = index;
    emit(ChangeTabview());
  }

  ////////////////////////
// accepted orders

  Stream<List<OrderModel>> acceptedOrders(String serviceName, String uId) {
    return FirebaseFirestore.instance
        .collection("orders")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((element) => element.data()["serviceName"] == serviceName)
          .where((element) => element.data()["status"] == "underway")
          .where((element) => element.data()['technicalUId'] == uId)
          .map((e) => OrderModel.fromJson(e.data()))
          .toList();
    });
  }

  Stream<List<OrderModel>> onWaitingOrders() async* {
    List<String> ordersUid = [];

    final offersSnapshot =
        await FirebaseFirestore.instance.collection("offers").get();

    offersSnapshot.docs
        .where((element) => element.data()['uId'] == originalUser!.uid)
        .where((element) => element.data()['status'] == 'waiting')
        .forEach((element) {
      print(element.data()['orderUId']);
      ordersUid.add(element.data()['orderUId']);
    });

    yield* FirebaseFirestore.instance
        .collection('orders')
        .where('orderUid', whereIn: ordersUid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((element) => element.data()['status'] == 'waiting')
            .map((e) => OrderModel.fromJson(e.data()))
            .toList());
  }

//remove offer
  void removeOfferWithOrder({required String orderUId}) {
    FirebaseFirestore.instance.collection('offers').get().then((value) {
      value.docs.where((element) => element.data()['orderUId']== orderUId).forEach((element) {
        print(element.id);
        FirebaseFirestore.instance.collection('offers').doc(element.id).delete();
      });
    });
  }






















}
