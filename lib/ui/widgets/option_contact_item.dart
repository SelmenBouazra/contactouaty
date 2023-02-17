import 'package:contactouaty/data/contact_option.dart';
import 'package:flutter/material.dart';

class OptionContactItem extends StatelessWidget {
  const OptionContactItem({
    Key? key,
    required this.contactOption,
  }) : super(key: key);

  final ContactOption contactOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.all(20.0),
      child: InkWell(
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/${contactOption.image}',
            ),
            radius: 20,
          ),
          onTap: () {}),
    );
  }
}
