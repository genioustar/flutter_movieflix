import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BuyButtonWidgets extends StatelessWidget {
  const BuyButtonWidgets({
    required this.url,
    super.key,
  });

  final String url;
  onButtonTap() async {
    bool launched = await launchUrlString(url);
    if (!launched) {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(child: Text('Buy Ticket')),
      ),
    );
  }
}
