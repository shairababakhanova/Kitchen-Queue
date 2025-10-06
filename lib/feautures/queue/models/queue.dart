import 'package:kitchen_queue/feautures/queue/models/user.dart';

class Queue {
  final String? id;
  final User? user;
  final DateTime date;

  Queue({
    this.id,
    this.user,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'user': user?.toJson(),
    };
  }

  factory Queue.fromJson(Map<String, dynamic> json) {
    return Queue(
      id: json['id'] as String?,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : DateTime.now(),
    );
  }
}