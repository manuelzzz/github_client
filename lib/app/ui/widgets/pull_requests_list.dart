import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:github_client/app/services/url_launcher.dart';

class PullRequestsList extends StatefulWidget {
  final GitHub github;

  const PullRequestsList({
    super.key,
    required this.github,
  });

  @override
  State<PullRequestsList> createState() => _PullRequestsListState();
}

class _PullRequestsListState extends State<PullRequestsList> {
  @override
  initState() {
    super.initState();
    _issues = widget.github.issues.listByUser().toList();
  }

  late Future<List<Issue>> _issues;
  final _urlLauncher = UrlLauncher();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Issue>>(
      future: _issues,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var assignedIssues = snapshot.data;
        return ListView.builder(
          itemBuilder: (context, index) {
            var assignedIssue = assignedIssues[index];
            return ListTile(
              title: Text(assignedIssue.title),
              subtitle: Text('${_nameWithOwner(assignedIssue)} '
                  'Issue #${assignedIssue.number} '
                  'opened by ${assignedIssue.user?.login ?? ''}'),
              onTap: () => _urlLauncher.launch(context, assignedIssue.htmlUrl),
            );
          },
          itemCount: assignedIssues!.length,
        );
      },
    );
  }

  String _nameWithOwner(Issue assignedIssue) {
    final endIndex = assignedIssue.url.lastIndexOf('/issues/');
    return assignedIssue.url.substring(29, endIndex);
  }
}
