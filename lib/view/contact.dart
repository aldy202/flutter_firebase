import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:materi_firebase/controller/auth_controller.dart';
import 'package:materi_firebase/controller/contact_controller.dart';
import 'package:materi_firebase/view/add_contact.dart';
import 'package:materi_firebase/view/login.dart';
import 'package:materi_firebase/view/update_contact.dart';

import '../controller/contact_controller.dart';
import 'add_contact.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var cc = ContactController();
  final authController = AuthController();

  Future<void> handleLogout(BuildContext context) async {
    await authController.logout();
    // Perform any additional tasks after logout if needed
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  @override
  void initState() {
    cc.getContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Contact List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  handleLogout(context);
                },
                child: Text('Logout')),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: cc.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final List<DocumentSnapshot> data = snapshot.data!;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onLongPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateContact(
                                    id: data[index]['id'],
                                    beforenama: data[index]['name'],
                                    beforephone: data[index]['phone'],
                                    beforeemail: data[index]['email'],
                                    beforeaddress: data[index]['address'],
                                  ),
                                ));
                          },
                          child: Card(
                            elevation: 8,
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    data[index]['name']
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(data[index]['name']),
                                subtitle: Text(data[index]['phone']),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    cc.deleteContact(
                                        data[index]['id'].toString());
                                    setState(() {
                                      cc.getContact();
                                    });
                                  },
                                )),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddContact(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
