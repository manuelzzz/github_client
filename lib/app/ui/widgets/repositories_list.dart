import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoriesList extends StatefulWidget {
  final GitHub github;

  const RepositoriesList({
    super.key,
    required this.github,
  });

  @override
  State<RepositoriesList> createState() => _RepositoriesListState();
}

class _RepositoriesListState extends State<RepositoriesList> {
  @override
  void initState() {
    super.initState();
    _repositories = widget.github.repositories.listRepositories().toList();
  }

  late Future<List<Repository>> _repositories;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repositories,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var repositories = snapshot.data;
        return ListView.builder(
          itemBuilder: (context, index) {
            var repository = repositories![index];
            return ListTile(
              title:
                  Text('${repository.owner?.login ?? ''}/${repository.name}'),
              subtitle: Text(repository.description),
              onTap: () => _launchUrl(context, repository.htmlUrl),
            );
          },
        );
      },
    );
  }
}

Future<void> _launchUrl(BuildContext context, String url) async {
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
