class Comment {
  final String? id;
  final String authorName;
  final String text;
  final DateTime dateTime;
  final String? imageBase64;
  final String queueKey;

  Comment({
    this.id,
    required this.authorName,
    required this.text,
    required this.dateTime,
    this.imageBase64,
    required this.queueKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'text': text,
      'dateTime': dateTime.toIso8601String(),
      'imageBase64': imageBase64,
      'queueKey': queueKey,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      authorName: json['authorName'] as String,
      text: json['text'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      imageBase64: json['imageBase64'] as String?,
      queueKey: json['queueKey'] as String,
    );
  }

  Comment copyWith({
    String? id,
    String? authorName,
    String? text,
    DateTime? dateTime,
    String? imageBase64,
    String? queueKey,
  }) {
    return Comment(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      text: text ?? this.text,
      dateTime: dateTime ?? this.dateTime,
      imageBase64: imageBase64 ?? this.imageBase64,
      queueKey: queueKey ?? this.queueKey,
    );
  }


}