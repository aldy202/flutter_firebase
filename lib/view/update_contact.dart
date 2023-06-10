import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:materi_firebase/controller/contact_controller.dart';
import 'package:materi_firebase/model/contact_model.dart';
import 'package:materi_firebase/view/contact.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact(
      {super.key,
      this.id,
      this.beforenama,
      this.beforephone,
      this.beforeemail,
      this.beforeaddress});

  final String? id;
  final String? beforenama;
  final String? beforephone;
  final String? beforeemail;
  final String? beforeaddress;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var contatcController = ContactController();
  final formkey = GlobalKey<FormState>();

  String? newname;
  String? newphone;
  String? newemail;
  String? newaddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Name'),
                  onChanged: (value) {
                    newname = value;
                  },
                  initialValue: widget.beforenama,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Phone'),
                  onChanged: (value) {
                    newphone = value;
                  },
                  initialValue: widget.beforephone,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    newemail = value;
                  },
                  initialValue: widget.beforeemail,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Address'),
                  onChanged: (value) {
                    newaddress = value;
                  },
                  initialValue: widget.beforeaddress,
                ),
                ElevatedButton(
                    child: const Text('Update Contact'),
                    onPressed: () {
                      ContactModel cm = ContactModel(
                          id: widget.id!,
                          name: newname!,
                          phone: newphone!,
                          email: newemail!,
                          address: newaddress!);
                      contatcController.updateContact(widget.id.toString(),cm);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Contact Updated')));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Contact()));
                      // print(newname);
                    })
              ],
            )),
      ),
    );
  }
}