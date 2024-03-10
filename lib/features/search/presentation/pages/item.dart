import 'package:flutter/material.dart';
import 'package:github_repo_search/features/search/data/repo.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubItem extends StatelessWidget {
  final RepoDataModel repo;
  GithubItem(this.repo);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _launchURL(repo.htmlUrl),
        highlightColor: Colors.lightBlueAccent,
        splashColor: Colors.red,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(repo.name ?? '-', // Using null-aware operator for fallback
                  style: Theme.of(context).textTheme.subtitle1), // Updated from .subhead
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                    repo.description ?? 'No description', // Using null-aware operator for fallback
                    style: Theme.of(context).textTheme.bodyText2), // Updated from .body1
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(repo.owner ?? '', // Using null-aware operator for fallback
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.deepOrange,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                                '${repo.watchersCount}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(repo.language ?? '', // Using null-aware operator for fallback
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.caption),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }
}
