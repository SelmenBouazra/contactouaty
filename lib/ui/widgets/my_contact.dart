import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../data/contact.dart';
import '../../local/contact_db.dart';
import 'contact_item.dart';

class MyContacts extends StatefulWidget {
  const MyContacts({Key? key}) : super(key: key);

  @override
  State<MyContacts> createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  List<Contact> contacts = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getContact(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Column();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: scanQr,
                  child: const Icon(
                    Icons.qr_code_scanner,
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, position) {
                      return ContactItem(
                        contact: contacts[position],
                        callback: () {
                          deleteContact(contacts[position].id);
                        },
                      );
                    }),
              )
            ],
          );
        });
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((value) {
        setState(() {
          insetScanContact(value);
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> insetScanContact(String value) async {
    Contact contact = Contact.fromJson(jsonDecode(value));
    await ContactDataBase.instance.insertContact(contact);
  }

  Future<void> getContact() async {
    contacts = await ContactDataBase.instance.getAllContacts();
  }

  Future deleteContact(int? id) async {
    await ContactDataBase.instance.deleteContact(id);
    setState(() {
      contacts;
    });
  }
}
