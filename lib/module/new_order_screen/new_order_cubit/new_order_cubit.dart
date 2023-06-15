import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_cubit/new_order_states.dart';

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

  List<String> listOfUrls = [];
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  int uploadItem = 0;// List of selected image
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
      print('something wrong ' + e.toString());
    }
  }

  clearImage(int index) {
    imageFileList!.removeAt(index);
    emit(
      NewOrderClearPickedImageState(),
    );
  }
  
  Future <String> uploadFile(XFile image)async {
    Reference reference = firebaseStorage.ref().child("order_images").child(image.name+DateTime.now().microsecondsSinceEpoch.toString());
    UploadTask uploadTask = reference.putFile(File(image.path));
    await uploadTask.whenComplete((){
      print(reference.getDownloadURL());
    });
    return await reference.getDownloadURL();
  }

  void uploadImage(List<XFile>images ) async {
    for(int i =0;i<images.length;i++){
     var imageUrl= uploadFile(images[i]);
     listOfUrls.add(imageUrl.toString());
    }
    emit(NewOrderUploadImageToFirebaseState());
    // var snapshot = await firebaseStorage
    //     .ref()
    //     .child('images/imageName${DateTime.now().microsecondsSinceEpoch}')
    //     .putFile(image!);
    // var downloadUrl = await snapshot.ref.getDownloadURL();
    // imageUrl = downloadUrl;
    // listOfUrls.add(imageUrl!);
    //
    // emit(
    //   NewOrderUploadImageToFirebaseState(),
    // );
    // return imageUrl;
  }

// imageOrderDisplay() {
//   imageFileList = listOfUrls;
//   emit(NewOrderDisplayImageState());
// }

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
