import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_bloc.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_event.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_state.dart';
import 'package:github_repo_search/features/search/data/repo_data_model.dart';
import 'package:mockito/mockito.dart';
import '../domain/data_repository_mock.dart.mocks.dart';

void main() {
  group('RepoSearchBloc Tests', () {
    late RepoSearchBloc bloc;
    late MockDataRepository mockDataRepository;

    setUp(() {
      mockDataRepository = MockDataRepository();
      bloc = RepoSearchBloc(mockDataRepository);
    });

    test('initial state is correct', () {
      expect(bloc.state, equals(SearchInitialState()));
    });

    blocTest<RepoSearchBloc, RepoSearchState>(
      'emits [SearchLoadingState, SearchLoadedState] on successful search query',
      build: () {
        when(mockDataRepository.getRepositoriesWithSearchQuery(any))
            .thenAnswer((_) async => [
                  RepoDataModel(
                      htmlUrl: 'https://github.com/octocat/Hello-World',
                      watchersCount: 80,
                      language: 'Dart',
                      description: 'This your first repo!',
                      name: 'Hello-World',
                      owner: 'octocat')
                ]);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('Hello-World')),
      expect: () => [
        SearchLoadingState(),
        isA<SearchLoadedState>(),
      ],
    );

    blocTest<RepoSearchBloc, RepoSearchState>(
      'emits [SearchInitialState] on clear search',
      build: () => bloc,
      act: (bloc) => bloc.add(ClearSearch()),
      expect: () => [SearchInitialState()],
    );

    tearDown(() {
      bloc.close();
    });
  });
}
