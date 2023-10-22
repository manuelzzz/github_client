import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:github/github.dart';
import 'package:github_client/app/ui/widgets/issues_list.dart';
import 'package:github_client/app/ui/widgets/pull_requests_list.dart';
import 'package:github_client/app/ui/widgets/repositories_list.dart';

class GithubSummary extends StatefulWidget {
  final GitHub github;
  const GithubSummary({
    super.key,
    required this.github,
  });
  @override
  State<GithubSummary> createState() => _GithubSummaryState();
}

class _GithubSummaryState extends State<GithubSummary> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          onDestinationSelected: (index) {
            setState(
              () => _selectedIndex = index,
            );
          },
          labelType: NavigationRailLabelType.selected,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Octicons.repo),
              label: Text('Repositories'),
            ),
            NavigationRailDestination(
              icon: Icon(Octicons.issue_opened),
              label: Text('Issues'),
            ),
            NavigationRailDestination(
              icon: Icon(Octicons.git_pull_request),
              label: Text('Pull Requests'),
            ),
          ],
          selectedIndex: _selectedIndex,
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              RepositoriesList(github: widget.github),
              IssuesList(github: widget.github),
              PullRequestsList(github: widget.github),
            ],
          ),
        ),
      ],
    );
  }
}
