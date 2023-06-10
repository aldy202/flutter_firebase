import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:materi_firebase/view/update_contact.dart';

import '../model/contact_model.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contact');

  final StreamController<List<DocumentSnapshot>> streamController = 
  StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();
    final DocumentReference docRef = await contactCollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.add(contact.docs);
    return contact.docs;
  }

  Future updateContact(String docId,ContactModel contactModel) async {
    final ContactModel ctmModel = ContactModel(
        name: contactModel.name,
        phone: contactModel.phone,
        email: contactModel.email,
        address: contactModel.address,
        id: docId,
        );

        final DocumentSnapshot documentSnapshot = 
        await contactCollection.doc(docId).get();
        if (!documentSnapshot.exists) {
          print('contact with ID $docId does not exist');
          return;
        }
        final updateContact = ctmModel.toMap();
        await contactCollection.doc(docId).update(updateContact);
        await getContact();
        print('update contact with ID: $docId');
    
  }

  Future deleteContact(String id) async {
    final contact = await contactCollection.doc(id).delete();
    return contact;
  }
  
  
}