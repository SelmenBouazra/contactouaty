import 'package:contactouaty/data/contact.dart';
import 'package:flutter/material.dart';

import '../../data/contact_option.dart';
import '../../local/contact_db.dart';
import 'my_card.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  Future<List<ContactOption>> getOptions(int? id) async {
    return await ContactDataBase.instance.getAllOption(id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: InkWell(
        onTap: () async {
          List<ContactOption> options = await getOptions(contact.id);
          Contact contactWithOptions =
              Contact(null, contact.name, contact.job, options);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyCard(contact: contactWithOptions),
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
