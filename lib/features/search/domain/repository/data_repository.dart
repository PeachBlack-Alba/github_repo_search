import 'package:github_repo_search/features/search/data/api.dart';
import 'package:github_repo_search/features/search/data/repo_data_model.dart';

class DataRepository {
  Future<List<RepoDataModel>> getTrendingRepositories() => Api.getTrendingRepositories();

  Future<List<RepoDataModel>> getRepositoriesWithSearchQuery(String query) =>
      Api.getRepositoriesWithSearchQuery(query);
}