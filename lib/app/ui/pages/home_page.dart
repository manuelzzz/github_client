import 'package:flutter/material.dart';
import 'package:github_client/app/ui/widgets/github_login.dart';
import 'package:window_to_front/window_to_front.dart';
import '../../../github_0auth_credentials.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      builder: (context, httpClient) {
        WindowToFront.activate();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Github Client'),
          ),
        );
      },
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }
}