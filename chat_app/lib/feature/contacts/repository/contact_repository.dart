import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/routes/routes_name.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactRepositoryProvider =
    Provider((ref) => ContactRepository(firestore: FirebaseFirestore.instance));

class ContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository({required this.firestore});

  // give only those contacts that has been registered to whats app
  Future<List<UserModel>> getChatAppContact(List<Phone> contacts) async {
    List<UserModel> contactUsers = [];
    for (var phone in contacts) {
      var querySnapshot = await firestore
          .collection('users')
          .where('phoneNumber',
              isEqualTo: phone.number.replaceAll(" ", ""),
              isNotEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var user = UserModel.fromJson(querySnapshot.docs.first.data());
        contactUsers.add(user);
      }
    }
    print("Contsct screen --> $contactUsers");
    return contactUsers;
  }

  Future<List<Contact>> getMobileContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
            withProperties: true,
            withPhoto: true,
            withThumbnail: true,
            withAccounts: true,
            withGroups: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    print("contacts => $contacts");
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromJson(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(' ', '');

        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, RoutesName.chat, arguments: userData);
        }
      }
      if (!isFound) {
        Utils.showSnackBar("This number does not exist on this app", context);
      }
    } catch (e) {
      Utils.showSnackBar(e.toString(), context);
    }
  }
}
