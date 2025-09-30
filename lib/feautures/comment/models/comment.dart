class Comment {
  final String authorName;
  final String text;
  final DateTime dateTime;
  final String? imagePath;
  final String queueKey;

  Comment({
    required this.authorName,
    required this.text,
    required this.dateTime,
    this.imagePath,
    required this.queueKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'text': text,
      'dateTime': dateTime.toIso8601String(),
      'imagePath': imagePath,
      'queueKey': queueKey,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      authorName: json['authorName'] as String,
      text: json['text'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      imagePath: json['imagePath'] as String?,
      queueKey: json['queueKey'] as String,
    );
  }


}