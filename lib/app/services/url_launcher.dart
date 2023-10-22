import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  Future<void> launch(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // ignore: use_build_context_synchronously
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Navigation error'),
          content: Text('Could not launch $url'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }
}
