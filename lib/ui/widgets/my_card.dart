import 'dart:convert';

import 'package:contactouaty/ui/widgets/qr_image.dart';
import 'package:flutter/material.dart';

import '../../data/contact.dart';
import '../../data/contact_option.dart';
import '../create_card_page.dart';
import 'option_contact_item.dart';

class MyCard extends StatelessWidget {
  const MyCard({Key? key, required this.contact}) : super(key: key);
  final Contact contact;

  Iterable<ContactOption> getContactOption() {
    return contact.contactOptions.where((element) => element.url.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreateCardPage(contact: contact)));
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ))
              ],
            ),
            Container(
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/profile.jpg",
                ),
                radius: 80,
              ),
            ),
            Container(
              child: Text(
                contact.name,
                style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Pacifico"),
              ),
            ),
            Container(
              child: Text(
                contact.job,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "SourceSansPro"),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: getContactOption().length,
                  itemBuilder: (context, position) {
                    return OptionContactItem(
                      contactOption: getContactOption().elementAt(position),
                    );
                  },
                ),
              ),
            ),
            //Expanded(child: QRImage(contact.toString()))
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(40),
              child: QRImage(jsonEncode(contact.toMap())),
            ))
          ],
        ),
      ),
    );
  }
}
