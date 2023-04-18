import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_cubit/new_order_states.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../models/category_model.dart';
import 'package:flutter/material.dart';

class NewOrderCubit extends Cubit<NewOrderStates> {
  NewOrderCubit() : super(NewOrderInitialState());

  static NewOrderCubit get(context) => BlocProvider.of(context);

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

  // File? image;
  //
  // List<XFile>? imageFileList = [];
  // List<String> listOfUrls = [
  //   // "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
  //   //
  //   // "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
  //   // "https://upload.wikimedia.org/wikipedia/commons/7/77/Big_Nature_%28155420955%29.jpeg",
  //   // "https://s23574.pcdn.co/wp-content/uploads/Singular-1140x703.jpg",
  //   // "https://www.expatica.com/app/uploads/sites/9/2017/06/Lake-Oeschinen-1200x675.jpg",
  // ];
  //
  // final imagePicker = ImagePicker();
  //
  // Future getImage() async {
  //   final pickedImages =
  //       await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (pickedImages != null) {
  //     image = File(pickedImages.path);
  //   } else {
  //     print('No image selected');
  //   }
  //
  //   emit(NewOrderPickImageState());
  // }

  clearImage() {
    image = null;
    emit(NewOrderClearPickedImageState());
  }
  bool uploading = false;
  String? imageUrl;
  File? image;




  uploadImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    PickedFile? image;
    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted){
      //Select Image
      image = await imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);
      if (image != null){
        //Upload to Firebase
        var snapshot = await firebaseStorage.ref()
            .child('images/imageName')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();

          imageUrl = downloadUrl;

      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  // Future<String?> uploadToFireStore() async {
  //
  //
  //   // File file = File(image!.path);
  //   // String imageName = 'orderImage/${DateTime.now().microsecondsSinceEpoch}';
  //   // String? imageUrl;
  //   // try{
  //   //   await FirebaseStorage.instance.ref(imageName).putFile(file);
  //   //   imageUrl = await FirebaseStorage.instance.ref(imageName).getDownloadURL();
  //   //   if(imageUrl!=null){
  //   //     image =null;
  //   //     print(imageUrl);
  //   //     emit(NewOrderUploadImageToFirebaseState());
  //   //   }
  //   // }on FirebaseException catch(error){
  //   //   showToast(message: '$error Cancelled', toastColor: primaryColor);
  //   // }
  //
  //
  //   return null;
  // }

}
