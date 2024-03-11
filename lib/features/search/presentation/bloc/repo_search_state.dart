import 'package:github_repo_search/features/search/data/repo_data_model.dart';

abstract class RepoSearchState {}

class SearchInitialState extends RepoSearchState {}

class SearchLoadingState extends RepoSearchState {}

class SearchLoadedState extends RepoSearchState {
  final List<RepoDataModel> repos;

  SearchLoadedState(this.repos);
}

class SearchErrorState extends RepoSearchState {
  final String message;

  SearchErrorState(this.message);
}
