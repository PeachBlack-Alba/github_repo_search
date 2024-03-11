import 'package:flutter/material.dart';
import 'package:github_repo_search/features/detail/data/issue_data_model.dart';
import 'package:github_repo_search/features/detail/domain/repository/details_page_repository.dart';
import 'package:github_repo_search/features/search/data/repo_data_model.dart';


class DetailsPage extends StatelessWidget {
  final RepoDataModel repo;

  const DetailsPage({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailsPageRepository dataRepository = DetailsPageRepository();

    return Scaffold(
      appBar: AppBar(
        title: Text('${repo.owner}/${repo.name} Issues'),
      ),
      body: FutureBuilder<List<Issue>>(
        future: dataRepository.fetchOpenIssues(repo.owner, repo.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData) {
            final issues = snapshot.data!;
            return ListView.builder(
              itemCount: issues.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(issues[index].title),
                  subtitle: Text('Created at: ${issues[index].createdAt}'),
                );
              },
            );
          } else {
            return Center(child: Text('No open issues found.'));
          }
        },
      ),
    );
  }
}
