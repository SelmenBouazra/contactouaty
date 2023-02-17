import 'dart:convert';

import 'package:contactouaty/ui/widgets/my_card.dart';
import 'package:contactouaty/ui/widgets/my_contact.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Contact contact;

  Future<void> _getUserCard() async {
    final prefs = await SharedPreferences.getInstance();
    var userCard = prefs.getString("user_card" ?? "");
    var user = jsonDecode(userCard!);
    contact = Contact.fromJson(user);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUserCard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Placeholder();
          }
          return Scaffold(
            backgroundColor: Colors.teal,
            body: SafeArea(
              child: PageView(
                children: [MyCard(contact: contact), MyContacts()],
              ),
            ),
          );
        });
  }
}
