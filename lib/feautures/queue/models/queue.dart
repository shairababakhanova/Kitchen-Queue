import 'package:kitchen_queue/feautures/queue/models/user.dart';

class Queue {
  final User? user;
  final User? userId;
  final DateTime date;

  Queue({
    required this.user,
    required this.userId,
    required this.date
  });
}