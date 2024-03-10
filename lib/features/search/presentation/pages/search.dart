import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo_search/features/search/presentation/pages/item.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_bloc.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_event.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_state.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchQueryController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchChanged);
    _searchQueryController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchQueryController.text;
    if (query.length >= 4) {
      context.read<RepoSearchBloc>().add(SearchQueryChanged(query));
    } else {
      context.read<RepoSearchBloc>().add(ClearSearch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchQueryController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search GitHub Repositories...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white30),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
      body: BlocConsumer<RepoSearchBloc, RepoSearchState>(
        listener: (context, state) {
          if (state is SearchErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          // ATENTION: Solution problem 2: Directly check the length of the query here
          if (_searchQueryController.text.length < 4) {
            return Center(
              child: Text('Type at least 4 characters to start the search.'),
            );
          }

          if (state is SearchLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoadedState) {
            return ListView.builder(
              itemCount: state.repos.length,
              itemBuilder: (BuildContext context, int index) {
                return GithubItem(state.repos[index]);
              },
            );
          } else if (state is SearchErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(
            child: Text('Type at least 4 characters to start the search.'),
          );
        },
      ),
    );
  }
}
