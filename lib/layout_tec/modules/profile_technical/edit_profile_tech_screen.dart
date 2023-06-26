import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/module/google_maps_widget/google_maps_widget.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class EditProfileTechnicalScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditProfileTechnicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back,
              color: Colors.white
          ),
          onPressed: () {
            // cubit.profilePic = null;
            // Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Edit profile",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),

        /// Button for Updating Profile (move it to bottomNavigationBar to implement editing profile)
        // actions: [
        //   // if (cubit.profilePic != null ||
        //   //     nameController.text != cubit.originalUser!.profileName ||
        //   //     addressController.text != cubit.originalUser!.address ||
        //   //     cubit.currentPosition != cubit.originalUser!.gpsLocation)
        //   //   Padding(
        //   //       padding: const EdgeInsets.all(5.0),
        //   //       child: Container(
        //   //         height: double.maxFinite,
        //   //         clipBehavior: Clip.antiAlias,
        //   //         decoration: const BoxDecoration(
        //   //           color: secondaryColor,
        //   //           borderRadius: BorderRadius.all(
        //   //             Radius.circular(10.0),
        //   //           ),
        //   //           boxShadow: <BoxShadow>[
        //   //             BoxShadow(
        //   //               color: Colors.black26,
        //   //               blurRadius: 10.0,
        //   //               offset: Offset(0.0, 0.75),
        //   //             ),
        //   //           ],
        //   //         ),
        //   //         child: MaterialButton(
        //   //           onPressed: () {
        //   //             if (cubit.profilePic != null) {
        //   //               cubit.uploadProfilePic(
        //   //                 profileName: nameController.text,
        //   //                 address: addressController.text,
        //   //               );
        //   //             } else {
        //   //               cubit.updateUserProfile(
        //   //                 profileName: nameController.text,
        //   //                 address: addressController.text,
        //   //                 gpsLocation: cubit.currentPosition,
        //   //               );
        //   //             }
        //   //           },
        //   //           child: state is UploadProfilePicLoadingState ||
        //   //               state is GetUserDataLoadingState
        //   //               ? const SizedBox(
        //   //               width: 25,
        //   //               height: 25,
        //   //               child: CircularProgressIndicator(
        //   //                 color: Colors.white,
        //   //               ))
        //   //               : const Text(
        //   //             "Update",
        //   //             style: TextStyle(
        //   //               fontFamily: 'Roboto',
        //   //               color: Colors.white,
        //   //               fontSize: 18.0,
        //   //             ),
        //   //           ),
        //   //         ),
        //   //       )),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //TOP BACKGROUND COLOR/AVATAR/AVATAR FRAME/EDIT BUTTON
            Stack(
              children: [
                // BACKGROUND
                Container(
                  height: size.height * 0.2,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 1.6,
                  child: SizedBox(
                    width: 150,
                    height: 130,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // AVATAR WHITE BORDER
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                        ),
                        // AVATAR
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:  NetworkImage(''),


                          // cubit.profilePic == null
                          //     ? NetworkImage(
                          //     cubit.originalUser!.profilePic!)
                          //     : FileImage(File(cubit.profilePic!.path))
                          // as ImageProvider,


                          radius: 55,
                        ),
                        // ICON TO CHOOSE PIC FROM GALLERY
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // cubit.getProfilePic();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(5),
                              backgroundColor:
                              secondaryColor, // <-- Button color
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Icon(
                                TablerIcons.camera_plus,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // THE CONTENT OF THE PAGE
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Username
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Username
                          Text(
                            "@username",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          // Edit Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Company Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 15),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              defaultTextFormField(
                                hintText: 'Name / old name',
                                maxLength: 50,
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name can not be empty!';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          // Edit Email
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 15),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              defaultTextFormField(
                                hintText: 'email / old email',
                                maxLength: 50,
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email can not be empty!';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          // Edit phone
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone Number",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 15),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              defaultTextFormField(
                                hintText: '+20 phone',
                                maxLength: 50,
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'phone cannot be empty!';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          // Edit Address
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Address",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 15),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              defaultTextFormField(
                                hintText: 'old address',
                                maxLength: 50,
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'address cannot be empty!';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                      // Map
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: GoogleMapsWidget(),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 0,
          fixedSize: Size.fromHeight(56),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero),
          ),
        ),
        child: Text(
          'Save',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500
          ),
        ),
        onPressed: (){
          //save and edit information of profile for technical
        },
      ),
    );
  }
}
