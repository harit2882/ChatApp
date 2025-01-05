import 'dart:io';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/repositories/firebase_storage_repository.dart';
import 'package:chat_app/utils/routes/routes_name.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.toString());
          },
          codeSent: ((String verificationId, int? resendToken) async {
            Navigator.pushNamed(context, RoutesName.otp,
                arguments: verificationId);
          }),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.toString(), context);
    }
  }

  bool isUserLoggedIn() {
    // TODO: implement isUserLoggedIn
    throw UnimplementedError();
  }

  void signOutUser() {
    // TODO: implement signOutUser
  }

  Stream<UserModel> userData(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()!));
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection("users").doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromJson(userData.data()!);
    }
    return user;
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.user_info, (route) => false);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Invalid OTP !!", context);
    }
  }

  void saveUserDataToFirebase(
      {required String name,
      required File? profilePic,
      required ProviderRef ref,
      required BuildContext context}) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          "https://img.freepik.com/premium-vector/avatar-man-with-glasses-portrait-young-guy-vector-illustration-face_217290-1809.jpg?w=2000";

      if (profilePic != null) {
        photoUrl = await ref
            .read(firebaseStorageRepositoryProvider)
            .storeFileToFirebase("profilePic/$uid", profilePic);
      }

      var user = UserModel(
          uid: uid,
          name: name,
          profilePic: photoUrl,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: [],
          isOnline: true,
          isSelect: false);

      firestore.collection('users').doc(uid).set(user.toJson());

      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.mob_layout, (route) => false);
    } catch (e) {
      Utils.showSnackBar(e.toString(), context);
    }
  }

  Future<void> setUserState(bool isOnline) async {
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({'isOnline': isOnline});
  }

  Future<void> setConversation(bool isOnline) async {
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({'isOnline': isOnline});
  }
}
