import 'package:kitchen_queue/feautures/queue/models/queue.dart';
import 'package:kitchen_queue/feautures/queue/models/user.dart';

class QueueState {
  final List<Queue> queues;
  final User? selectedUser;
  final User? selectedUserId;
  final DateTime selectedDate;

  QueueState({
    this.queues = const [],
    this.selectedUser,
    this.selectedUserId,
    DateTime? selectedDate
  }) : selectedDate = selectedDate ?? DateTime(2025);

  QueueState copyWith({
    final List<Queue>? queues,
    final User? selectedUser,
    final DateTime? selectedDate
  }) {
    return QueueState(
      queues: queues ?? this.queues,
      selectedUser : selectedUser ?? this.selectedUser,
      selectedDate: selectedDate ?? this.selectedDate
       );
  }
}