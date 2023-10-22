import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:github_client/app/services/url_launcher.dart';

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

  final _urlLauncher = UrlLauncher();
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
              onTap: () => _urlLauncher.launch(context, repository.htmlUrl),
            );
          },
        );
      },
    );
  }
}
