class Issue {
  final String title;
  final DateTime createdAt;

  Issue({required this.title, required this.createdAt});

  // Factory constructor to create an Issue instance from a JSON object.
  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
