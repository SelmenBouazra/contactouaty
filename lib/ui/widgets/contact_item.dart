import 'package:contactouaty/data/contact.dart';
import 'package:flutter/material.dart';

import 'my_card.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyCard(contact: contact),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/profile.jpg",
              ),
              radius: 20,
            ),
            Text(
              contact.name,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "SourceSansPro"),
            ),
            const Icon(
              Icons.list,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
