// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:com.example.while_app/resources/components/message/apis.dart';
// import 'package:com.example.while_app/utils/utils.dart';
// import 'package:com.example.while_app/view_model/session_controller.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// final profileControllerProvider = Provider<ProfileController>((ref) {
//   return ProfileController(ref: ref);
// });
// class ProfileController with ChangeNotifier {
//   final Ref _ref;
//   final databaseReference = FirebaseDatabase.instance.ref();
//   DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
//   firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;

//   final picker = ImagePicker();

//   File? _profileimage;
//   File? _bgimage;
//   File? get profileimage => _profileimage;
//   File? get bgimage => _bgimage;

//   bool _loading = false;
//   ProfileController({
//     required Ref ref,
//   }):_ref = ref;
//   bool get loading => _loading;

//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   Future pickGalleryImage(BuildContext context, String check) async {
//     final pickedFile =
//         await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

//     if (pickedFile != null) {
//       if (check == "Profile Picture") {
//         // print('//////////////profile updated ////////////');
//         _profileimage = File(pickedFile.path);
//         uploadProfileImage();
//         notifyListeners();
//       } else {
//         _bgimage = File(pickedFile.path);
//         uploadBgImage();
//         notifyListeners();
//       }
//     }
//   }

//   Future pickCameraImage(BuildContext context, String check) async {
//     final pickedFile =
//         await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

//     if (pickedFile != null) {
//       if (check == "Profile Picture") {
//         _profileimage = File(pickedFile.path);
//         uploadProfileImage();
//         notifyListeners();
//       } else {
//         _bgimage = File(pickedFile.path);
//         uploadBgImage();
//         notifyListeners();
//       }
//     }
//   }

//   void uploadProfileImage() async {
//     setLoading(true);
//     firebase_storage.Reference storageRef = firebase_storage
//         .FirebaseStorage.instance
//         .ref('/profileImage${FirebaseSessionController().uid!}');
//     firebase_storage.UploadTask uploadTask =
//         storageRef.putFile(File(profileimage!.path).absolute);
//     await Future.value(uploadTask);
//     final newUrl = await storageRef.getDownloadURL();
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(_ref.read(apisProvider).me.id)
//         .update({'profile': newUrl});
//     ref
//         .child(FirebaseSessionController().uid.toString())
//         .update({'profileImage': newUrl.toString()}).then((value) {
//       setLoading(true);
//       _profileimage = null;
//       Utils.toastMessage('Profile Updated');
//     }).onError((error, stackTrace) {
//       setLoading(true);
//       Utils.toastMessage(error.toString());
//     });
//   }

//   void uploadBgImage() async {
//     setLoading(true);
//     firebase_storage.Reference storageRef = firebase_storage
//         .FirebaseStorage.instance
//         .ref('/bgImage${FirebaseSessionController().uid!}');
//     firebase_storage.UploadTask uploadTask =
//         storageRef.putFile(File(bgimage!.path).absolute);
//     await Future.value(uploadTask);
//     final newUrl = await storageRef.getDownloadURL();
//     ref
//         .child(FirebaseSessionController().uid.toString())
//         .update({'bgImage': newUrl.toString()}).then((value) {
//       setLoading(true);
//       _bgimage = null;
//       Utils.toastMessage("Cover Updated");
//     }).onError((e, stackTrace) {
//       setLoading(true);
//       Utils.toastMessage(e.toString());
//     });
//   }
// }
