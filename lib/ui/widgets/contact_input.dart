import 'package:flutter/material.dart';

class ContactInput extends StatelessWidget {
  const ContactInput({Key? key, required this.controller, required this.hint})
      : super(key: key);
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          hintText: hint,
        ),
      ),
    );
  }
}
