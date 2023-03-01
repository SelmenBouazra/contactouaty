import 'package:contactouaty/data/contact_option.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionContactItem extends StatelessWidget {
  const OptionContactItem({
    Key? key,
    required this.contactOption,
  }) : super(key: key);

  final ContactOption contactOption;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse('https://$url');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

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
          onTap: () {
            _launchUrl(contactOption.url);
          }),
    );
  }
}
