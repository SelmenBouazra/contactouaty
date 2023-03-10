import 'dart:convert';

import 'package:contactouaty/data/contact_option.dart';
import 'package:contactouaty/ui/widgets/contact_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/contact.dart';
import 'home_page.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({Key? key, this.contact}) : super(key: key);
  final Contact? contact;

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController whatsUpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      nameController.text = widget.contact?.name ?? "";
      jobController.text = widget.contact?.job ?? "";
      emailController.text = widget.contact?.contactOptions
              .firstWhere(
                (element) => element.name == "Email",
              )
              .url ??
          "";
      facebookController.text = widget.contact?.contactOptions
              .firstWhere((element) => element.name == "Facebook")
              .url ??
          "";
      instagramController.text = widget.contact?.contactOptions
              .firstWhere((element) => element.name == "Instagram")
              .url ??
          "";
      tiktokController.text = widget.contact?.contactOptions
              .firstWhere((element) => element.name == "tiktok")
              .url ??
          "";
      linkedInController.text = widget.contact?.contactOptions
              .firstWhere((element) => element.name == "linkedin")
              .url ??
          "";
      whatsUpController.text = widget.contact?.contactOptions
              .firstWhere((element) => element.name == "WhatsApp")
              .url ??
          "";
    }
  }

  Contact _onCreateCardClick() {
    final contacts = [
      ContactOption("Facebook", facebookController.text, "facebook.png"),
      ContactOption("Instagram", instagramController.text, "instagram.png"),
      ContactOption("tiktok", tiktokController.text, "tiktok.png"),
      ContactOption("Email", emailController.text, "gmail.png"),
      ContactOption("linkedin", linkedInController.text, "linkedin.png"),
      ContactOption("WhatsApp", whatsUpController.text, "WhatsApp.png")
    ];

    return Contact(null, nameController.text, jobController.text, contacts);
  }

  Future<void> _addUserCard(Contact contact) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("user_card", jsonEncode(contact.toMap()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Contactouaty",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    fontFamily: "Pacifico"),
              ),
            ),
            const Text(
              "Create your digital business card",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "SourceSansPro"),
            ),
            ContactInput(
              controller: nameController,
              hint: 'Full name',
            ),
            ContactInput(
              controller: jobController,
              hint: 'Your job',
            ),
            ContactInput(
              controller: facebookController,
              hint: 'Your Facebook link',
            ),
            ContactInput(
              controller: instagramController,
              hint: 'Your Instagram link',
            ),
            ContactInput(
              controller: whatsUpController,
              hint: 'Your WhatsUp number',
            ),
            ContactInput(
              controller: emailController,
              hint: 'Your email',
            ),
            ContactInput(
              controller: linkedInController,
              hint: 'Your LinkedIn link',
            ),
            ContactInput(
              controller: tiktokController,
              hint: 'Your Tiktok link',
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: OutlinedButton(
                onPressed: () {
                  Contact contact = _onCreateCardClick();

                  if (contact.name.isNotEmpty &&
                      contact.job.isNotEmpty &&
                      contact.contactOptions
                          .where((element) => element.url.isNotEmpty)
                          .isNotEmpty) {
                    _addUserCard(contact);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else {
                    _dialogBuilder(context);
                  }
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                child: const Text(
                  "Create card",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "SourceSansPro"),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalidate data'),
          content: const Text('You should add your  name and your job\n'
              'and  at least a contact option.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
