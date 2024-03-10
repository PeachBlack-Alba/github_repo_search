class RepoDataModel {
  final int totalCount;
  final List<RepoDataItems> items;

  RepoDataModel({required this.totalCount, required this.items});

  factory RepoDataModel.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<RepoDataItems> itemsList = list.map((i) => RepoDataItems.fromJson(i)).toList();
    return RepoDataModel(
      totalCount: json['totalCount'],
      items: itemsList,
    );
  }
}

class RepoDataItems {
  final String fullName;
  final String? description;
  final String? language;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final int openIssuesCount;
  final RepoDataOwner owner;

  RepoDataItems({
    required this.fullName,
    this.description,
    this.language,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
    required this.owner,
  });

  factory RepoDataItems.fromJson(Map<String, dynamic> json) {
    return RepoDataItems(
      fullName: json['fullName'],
      description: json['description'],
      language: json['language'],
      stargazersCount: json['stargazersCount'],
      watchersCount: json['watchersCount'],
      forksCount: json['forksCount'],
      openIssuesCount: json['openIssuesCount'],
      owner: RepoDataOwner.fromJson(json['owner']),
    );
  }
}

class RepoDataOwner {
  final String avatarUrl;

  RepoDataOwner({required this.avatarUrl});

  factory RepoDataOwner.fromJson(Map<String, dynamic> json) {
    return RepoDataOwner(
      avatarUrl: json['avatarUrl'],
    );
  }
}
