import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo_search/features/search/presentation/pages/search.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_bloc.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_event.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_state.dart';
import 'item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Initially load trending repositories
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RepoSearchBloc>().add(SearchRefreshRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repo Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value:
                        BlocProvider.of<RepoSearchBloc>(context, listen: false),
                    child: SearchList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<RepoSearchBloc, RepoSearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RepoSearchBloc>().add(SearchRefreshRequested());
              },
              child: ListView.builder(
                itemCount: state.repos.length,
                itemBuilder: (BuildContext context, int index) {
                  return GithubItem(state.repos[index]);
                },
              ),
            );
          } else if (state is SearchErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Pull to refresh.'));
        },
      ),
    );
  }
}
