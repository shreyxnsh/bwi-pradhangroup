import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String pfpImageUrl = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    loadUserData(_auth.currentUser!.uid);
  }

  Future<void> pickImage(BuildContext context, String type) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    if (type == 'camera') {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      setState(() {
        isUploading = true;
      });

      // Upload the image to Firebase Storage
      String imageUrl = await uploadImageToStorage(pickedFile.path);

      // Update the profile picture URL in the database
      // await updateProfilePicture(context, imageUrl);

      setState(() {
        isUploading = false;
        // Update the state to indicate that image upload is complete
        imageUploaded = true;
        pfpImageUrl = imageUrl;
      });
      log("Image uploaded successfully. URL: $imageUrl");
      log("Image uploaded successfully. PFP URL: $pfpImageUrl");
    }
  }

  Future<void> loadUserData(String authId) async {
    var data = await FirebaseFunctions().fetchUserbyID(authId);
    log("User data loaded successfully : $data");
    log("User Name : ${data!.name}");
    log("User Email : ${data.email}");
    log("User Contact : ${data.phoneNo}");
    log("User PFP URL : ${data.profilePic}");
    setState(() {
      nameController.text = data.name;
      emailController.text = data.email;
      contactController.text = data.phoneNo;
      passwordController.text = data.password;
      pfpImageUrl = data.profilePic;
    });
  }

  Future<String> uploadImageToStorage(String imagePath) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("profile_images/${_auth.currentUser!.uid}");
      UploadTask uploadTask = storageReference.putFile(File(imagePath));
      await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      String downloadUrl = await storageReference.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print("Error uploading image to storage: $e");
      // Handle error, return a default image URL, or throw an exception
      return ""; // Return an empty string for simplicity; handle it based on your requirements
    }
  }

  bool isUploading = false;
  bool imageUploaded = false;

  @override
  Widget build(BuildContext context) {
    String uid = _auth.currentUser!.uid;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () async {
            // Get.to(
            //     () => bid(
            //           post: widget.post,
            //         ),
            //     transition: Transition.rightToLeftWithFade);
            if (nameController.text.isEmpty) {
              Get.snackbar('Error', 'Name cannot be empty');
              return;
            }
            if (emailController.text.isEmpty) {
              Get.snackbar('Error', 'Email cannot be empty');
              return;
            }
            if (passwordController.text.isEmpty) {
              Get.snackbar('Error', 'Password cannot be empty');
              return;
            }
            if (contactController.text.isEmpty) {
              Get.snackbar('Error', 'Contact cannot be empty');
              return;
            }

            log("Name : ${nameController.text}");
            log("Email : ${emailController.text}");
            log("Password : ${passwordController.text}");
            log("Contact : ${contactController.text}");
            log("UID : $uid");

            // Update the user's profile details in the database
            setState(() {
              isUploading = true;
            });
            await FirebaseFunctions().updateProfileData(
                uid,
                pfpImageUrl,
                nameController.text,
                emailController.text,
                passwordController.text,
                contactController.text);
            setState(() {
              isUploading = false;
              GetStorage().write('name', nameController.text);
              GetStorage().write('email', emailController.text);
              GetStorage().write('phoneNo', contactController.text);
              GetStorage().write('profilePic', pfpImageUrl);
            });
          },
          child: Container(
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: isUploading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Save Changes',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: 'Lexend',
                            color: Colors.white),
                      )),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27.5),
                            color: 'F4F5FA'.toColor(),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                          ),
                        ),
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27.5),
                          color: 'F4F5FA'.toColor(),
                        ),
                        child: Icon(
                          Icons.settings_outlined,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    String type = 'gallery';
                    await pickImage(context, type);
                    setState(() {
                      isUploading = false;
                    });
                  },
                  child: Center(
                    child: pfpImageUrl.isNotEmpty
                        ? CircleAvatar(
                            radius: 65,
                            backgroundColor: 'F4F5FA'.toColor(),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(pfpImageUrl),
                            ),
                          )
                        : Container(
                      alignment: Alignment.center,
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        border: Border.all(color: 'F4F4F4'.toColor(), width: 8),
                        borderRadius: BorderRadius.circular(65),
                      ),
                      child:
                      
                      Image.asset(
                        'assets/Camera.png',
                        height: 44,
                      ),
                    ),
                        
                        // Image.asset(
                        //     'assets/Camera.png',
                        //     height: 44,
                        //   ),

                    // Container(
                    //   alignment: Alignment.center,
                    //   height: 130,
                    //   width: 130,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: 'F4F4F4'.toColor(), width: 8),
                    //     borderRadius: BorderRadius.circular(65),
                    //   ),
                    //   child:
                    //   pfpImageUrl.isNotEmpty ?
                    //     CachedNetworkImage(imageUrl: pfpImageUrl)
                    //   :
                    //   Image.asset(
                    //     'assets/Camera.png',
                    //     height: 44,
                    //   ),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Name',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Lexend'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Name',
                    filled: true,
                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: nameController,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Lexend'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Email',
                    filled: true,
                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: emailController,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Lexend'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Password',
                    filled: true,
                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: passwordController,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Contact Number',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Lexend'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: '',
                    filled: true,
                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: contactController,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
