import 'package:chat_app/feature/contacts/repository/contact_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

final getChatAppContactsProvider =
FutureProvider.family<List<UserModel>, List<Phone>>((ref, contacts) async {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return await contactRepository.getChatAppContact(contacts);
});



final getMobileContactsProvider = FutureProvider((ref) async {
  return await ref.watch(contactRepositoryProvider).getMobileContacts();
});


final contactControllerProvider = Provider((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return ContactController(ref: ref, contactRepository: contactRepository);
});

class ContactController{

  final ProviderRef ref;
  final ContactRepository contactRepository;

  ContactController({required this.ref, required this.contactRepository});

  void selectedContact(Contact selectedContact, BuildContext context) async{

    contactRepository.selectContact(selectedContact, context);

  }
}