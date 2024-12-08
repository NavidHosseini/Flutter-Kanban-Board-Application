class Comment {
  final String userName;
  final String text;
  final DateTime createdAt;
  Comment({
    required this.userName,
    required this.text,
    required this.createdAt,
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userName: json['userName'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
