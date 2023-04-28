import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:rescpies/modulew/Single%20User%20Data.dart';
import '../modulew/Search data.dart';
import '../scr/Loginpage.dart';
import '../scr/Nav_bar.dart';
import '../shared_pref.dart';

class Authentication extends GetxController {

  String customer = "";
  String accessToken = "";
  String idToken = "";
  String? customerid;
  String? productid="";
  List<String>? favlist =[];
  List<String>? favlistimg =[];

  register(String email, String password, String name, String gender) async {
    Get.put(EasyLoading.show());
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final UserCredential authResult = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await authResult.user?.sendEmailVerification();
      await firestore.collection('users').doc(authResult.user?.uid).set({
        'name': name.toString(),
        'email': email.toString(),
        'password': password.toString(),
        'gender': gender.toString(),
        'createdAt': Timestamp.now(),
        'favourite':[].toList(),
      });
      Get.to(() => const Login());
      Get.snackbar("CookMate", "Registered Successfully",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.done, color: Colors.green),
          colorText: Colors.white);
      Get.put(EasyLoading.dismiss());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar("CookMate", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
      Get.put(EasyLoading.dismiss());
    }
  }

  login(String email, String password) async {
    Get.put(EasyLoading.show());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.emailVerified == true) {
        // Logged in successfully
        User? user = userCredential.user;
        String? idToken = await user?.getIdToken();
        // Get the ID token result, which includes the access token
        IdTokenResult? idTokenResult = await user?.getIdTokenResult();
        String? accessToken = idTokenResult?.token;
        customerid = user?.uid;
        if (kDebugMode) {
          print(accessToken);
          Sharedpreference().setuid(customerid.toString());
          Sharedpreference().setToken(accessToken.toString());
          print('ffffffffffffffffff');
          // print("User uid ============${uid}");
        }
        if (kDebugMode) {
          print(user);
        }
        if (kDebugMode) {
          print(idToken);
        }
        Get.put(EasyLoading.dismiss());
        Get.snackbar("ChatBox", "Login Successful",
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.done, color: Colors.green),
            colorText: Colors.white);
              Get.offAllNamed(Navigation.routeName);

        Sharedpreference().setLoggedIn(true);
        return "Success";
      } else {
        Get.put(EasyLoading.dismiss());
        return Get.snackbar("CookMate", "please verify your email",
            icon: const Icon(Icons.error, color: Colors.red
            ),
            snackPosition: SnackPosition.TOP);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Get.put(EasyLoading.dismiss());
        return Get.snackbar("CookMate", "Invalid Credentials",
            icon: const Icon(Icons.error, color: Colors.red
            ),
            snackPosition: SnackPosition.TOP);
      }
      Get.put(EasyLoading.dismiss());
      if (kDebugMode) {
        print(e.message);
      }
      return e.message;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.put(EasyLoading.dismiss());
      return e.toString();
    }
  }

  logoutshowAlertDialog(BuildContext context) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("no"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();

        // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>Bottom()));
      },
    );
    Widget continueButton = TextButton(
        child: const Text("yes"),
        onPressed: () async {
          Get.put(EasyLoading.show());
          await Sharedpreference().removeAll();
          Get.back();
          await FirebaseAuth.instance.signOut();
          Get.offAll(() => const Login());
          Get.put(EasyLoading.dismiss());
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Do you want exit the application"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  forgotpassword(String email) async {
    try {
      Get.put(EasyLoading.show());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.offAll(() => const Login());
      Get.put(EasyLoading.dismiss());
      Get.snackbar("ChatBox", "Check your Mail",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.done, color: Colors.green),
          colorText: Colors.white);
    } catch (e) {
      Get.put(EasyLoading.dismiss());
      Get.snackbar("CookMate", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  uploadpicgallery() async {
    final imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: ImageSource.gallery);
    if (kDebugMode) {
      print("${file?.path}");
    }
    String uniquefilename = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("profileimg");
    Reference referenceimagetoUpload = referenceDirImages.child(uniquefilename);
    try {


      await referenceimagetoUpload.putFile(File(file!.path));
      var profilepicUrl = await referenceimagetoUpload.getDownloadURL();
      Get.put(EasyLoading.show());
      if (kDebugMode) {
        print(profilepicUrl);
      }
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('users').doc(customerid).update({
        'profile_pic_url': profilepicUrl,
      }).then((value) {

        Get.put(EasyLoading.dismiss());
        Get.snackbar("CookMate", "Profile pic uploaded Successfully",
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.done, color: Colors.green),
            colorText: Colors.white);
        if (kDebugMode) {
          print('Field added successfully');
        }
      }).catchError((error) {
        Get.put(EasyLoading.dismiss());
        if (kDebugMode) {
          print('Failed to add field: $error');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    update();
  }

  uploadpiccamera() async
  {
    if (kDebugMode) {
      print("hiiii");
    }
    final imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: ImageSource.camera);
    if (kDebugMode) {
      print("${file?.path}");
    }
    String uniquefilename = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("profileimg");
    Reference referenceimagetoUpload = referenceDirImages.child(uniquefilename);
    try {

      await referenceimagetoUpload.putFile(File(file!.path));
      var profilepicUrl = await referenceimagetoUpload.getDownloadURL();
      if (kDebugMode) {
        print(profilepicUrl);
        print(customerid);
      }
      Get.put(EasyLoading.show());
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(customerid).update({
        'profile_pic_url': profilepicUrl.toString(),
      }).then((value) {

        Get.put(EasyLoading.dismiss());
        Get.snackbar("CookMate", "Profile pic uploaded Successfully",
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.done, color: Colors.green),
            colorText: Colors.white);
        if (kDebugMode) {
          Get.put(EasyLoading.dismiss());
          print('Field added successfully');
        }
      }).catchError((error) {
        if (kDebugMode) {
          Get.put(EasyLoading.dismiss());
          Get.snackbar("CookMate", "Session Expired please Logout and Again Login",
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(Icons.warning, color: Colors.yellowAccent),
              colorText: Colors.black);
          print('Failed to add field: $error');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    update();
  }

  fetchsingleuserdata() async {
    User? user = FirebaseAuth.instance.currentUser;
     Userdata loggedUser= Userdata();
       FirebaseFirestore.instance
           .collection("users")
           .doc(user!.uid)
           .get()
           .then((value) {

         loggedUser = Userdata.fromMap(value.data());
         if (kDebugMode) {
        print("done");
         }
       });
     update();
  }

  updatename(String name)async{
    try{
      await FirebaseFirestore.instance.collection('users').doc(customerid).update({
        'name': name.toString(),
      });
 if (kDebugMode) {

   print("hiiiiiiiiiiiiiiiii");
 }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
    update();
  }



}
