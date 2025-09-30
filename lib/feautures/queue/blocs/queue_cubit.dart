import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_queue/feautures/queue/blocs/queue_state.dart';
import 'package:kitchen_queue/feautures/queue/models/queue.dart';
import 'package:kitchen_queue/feautures/queue/models/user.dart';

class QueueCubit  extends Cubit<QueueState>{
  QueueCubit() : super(QueueState());

  final List<User> users = [
    User(name: 'Шаира Бабаханова', key: '1'),
    User(name: 'Ажар Ерболатқызы', key: '2'),
    User(name: 'Айбек Молдарақымұлы', key: '3'),
    User(name: 'Айгерім Ғабитқызы', key: '4'),
    User(name: 'Акрамжан Ахмеджанович', key: '5'),
  ];

  void addQueue(Queue queue) {
    emit(state.copyWith(queues: [... state.queues, queue])); 
  }

  void deleteQueue(int index) {
    final newQueue = List<Queue>.from(state.queues);
    newQueue.removeAt(index);
    emit(state.copyWith(queues: newQueue));
  }
  void updateSelectedDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateSelectedUser(User? user) {
    emit(state.copyWith(selectedUser: user));
  }

 void clearSelection() {
  final clearedState = QueueState(
    selectedUser: null,
    selectedDate: DateTime.now(),
    queues: state.queues,
  );
  emit(clearedState);
}
}